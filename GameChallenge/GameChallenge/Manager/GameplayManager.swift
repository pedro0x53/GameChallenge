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

    private(set) var statusManager: StatusManager!
    private(set) var boardManager: BoardManager!
    private(set) var handManager: HandManager!
    private(set) var speechManager: SpeechManager!

    let moveSystem = GKComponentSystem(componentClass: MovementComponent.self)

    private(set) var currentLegendID: Int = 0

    init(scene: SKScene) {
        self.scene = scene

        self.statusManager = StatusManager(manager: self)
        self.speechManager = SpeechManager(manager: self, legendID: currentLegendID)

        if let legend = Legend(identifier: currentLegendID) {
            self.add(entity: legend)
            self.boardManager = BoardManager(manager: self, legend: legend)
        }

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

        if let statusComponent = entity.component(ofType: StatusComponent.self) {
                self.scene.removeChildren(in: [statusComponent.node])
                self.scene.addChild(statusComponent.node)
        }
    }

    func remove(entity: GKEntity) {
        self.entities.remove(entity)

        self.moveSystem.removeComponent(foundIn: entity)

        entity.removeComponent(ofType: MovementComponent.self)
        entity.removeComponent(ofType: FollowComponent.self)

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
        self.handManager.reset()

        AnimationManager.drawCardsOut(scene: self.scene, entities: cardsOnHand) {
            for card in cardsOnHand {
                self.remove(entity: card)
            }
        }

        let newCards = self.boardManager.drawCards(cards: cardsOnHand)

        for card in newCards {
            self.handManager.add(card)
        }

        if cardsOnHand.isEmpty {
            AnimationManager.drawCardsIn(entities: newCards)
        } else {
            AnimationManager.drawCardsIn(entities: newCards, wait: 0.5)
        }

        self.speechManager.drawingNewHand()
    }

    func takeDamage() {
        self.speechManager.sayComment(.wrong)

        if !self.statusManager.update(status: .life) {
            self.gameOver()
        } else {
            if handManager.cards.isEmpty {
                self.drawCards()
            }
        }
    }

    func nextLevel() {
        if let legendFound = scene as? GameScene {
            legendFound.legendFound()
        }
    }

    func gameOver() {
        if let gameOver = scene as? GameScene {
            gameOver.goToGameOverScene()
        }
    }

   
    func putCardsOnTheTable(cards: [Card]) {
        for card in cards {
            if self.boardManager.add(card) {
                self.handManager.remove(card)
                if handManager.cards.isEmpty {
                    self.drawCards()
                }
            } else {
                self.handManager.backToHand(card)
            }
        }
    }

    func revealCard(_ point: CGPoint) {
        if self.statusManager.update(status: .reveal) {
            _ = self.boardManager.addCorrectCardOfDeckOnBoard()
        }
    }

    func update(_ deltaTime: CFTimeInterval) {
        moveSystem.update(deltaTime: deltaTime)
    }
}
