//
//  GameplayManager.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 15/03/21.
//

import GameplayKit
import SpriteKit

class GameplayManager {

    let scene: SKScene
    private var entities = Set<GKEntity>()

    // let statusManager: StatusManager
    var boardManager: BoardManager!
    var handManager: HandManager!

    let moveSystem = GKComponentSystem(componentClass: MovementComponent.self)

    init(scene: SKScene) {
        self.scene = scene

        let legend = Legend(identifier: 1)
        self.add(entity: legend)
        self.boardManager = BoardManager(manager: self, legend: legend)

        self.handManager = HandManager(manager: self)
        self.drawCards()
    }

    func add(entity: GKEntity) {
        self.entities.insert(entity)

        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            self.scene.removeChildren(in: [spriteComponent.node])
            self.scene.addChild(spriteComponent.node)
        }

        if let interactionComponent = entity.component(ofType: InteractionComponent.self) {
            self.scene.removeChildren(in: [interactionComponent.node])
            self.scene.addChild(interactionComponent.node)
        }
    }

    func remove(entity: GKEntity) {
        self.entities.remove(entity)

        self.moveSystem.removeComponent(foundIn: entity)

        var toRemove: [SKNode] = []
        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            toRemove.append(spriteComponent.node)
        }

        if let interactionComponent = entity.component(ofType: InteractionComponent.self) {
            toRemove.append(interactionComponent.node)
        }

        self.scene.removeChildren(in: toRemove)
    }

    func isOverLegend(point: CGPoint) -> Bool {
        return self.boardManager.isOverLegend(point: point)
    }

    func drawCards(_ point: CGPoint = CGPoint(x: 0, y: 0)) {
        let cardsOnHand = self.handManager.cards
        let newCards = self.boardManager.drawCards(cards: cardsOnHand)
        self.handManager.add(newCards)
    }

    func putCardsOnTheTable(cards: [Card]) {
        for card in cards {
            AnimationManager.zFall(entity: card)
            if self.boardManager.add(card) {
                self.handManager.remove(card)
            } else {
                self.handManager.backToHand(card)
            }
        }
    }

    func revealCard(_ point: CGPoint = CGPoint(x: 0, y: 0)) {
        let identifiers: [Int] = self.boardManager.cards.compactMap { card in
            guard let cardInfo = card.component(ofType: CardInfoComponent.self) else { return nil }
            return cardInfo.identifier
        }
    }

    func takeDamage() {}

    func nextLevel() {}

    func gameOver() {}

    func update(_ deltaTime: CFTimeInterval) {
        moveSystem.update(deltaTime: deltaTime)
    }
}
