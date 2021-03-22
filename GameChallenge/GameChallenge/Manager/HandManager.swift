//
//  HandManager.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 16/03/21.
//

import SpriteKit
import GameplayKit

class HandManager {
    private let gameplayManager: GameplayManager

    private(set) var cards = Set<Card>()
    private(set) var selectedCards = Set<Card>()

    private var isMoving: Bool = false

    private let responsiver = Responsiver(designSize: CGSize(width: 390, height: 844))

    init(manager: GameplayManager) {
        self.gameplayManager = manager
    }

    func add(_ card: Card) {
        if self.cards.count > 4 {
            return
        }

        self.cards.insert(card)

        guard let cardComponent = card.component(ofType: CardInfoComponent.self) else { return }

        let cardSize = responsiver.responsiveSize(for: CGSize(width: 100, height: 140))

        let randomPoint = CGPoint.randomCenterBased(in: gameplayManager.scene.size)

        let spriteComponent = SpriteComponent(assetName: cardComponent.assetName,
                                              size: cardSize,
                                              position: randomPoint)
        card.addComponent(spriteComponent)

        let interactionComponent = InteractionComponent(hitBox: cardSize,
                                                        position: randomPoint,
                                                        touchEndedAction: self.dropAction,
                                                        touchMovedAction: self.dragAction)
        card.addComponent(interactionComponent)

        gameplayManager.add(entity: card)
    }

    func remove(_ card: Card) {
        self.cards.remove(card)
    }

    func select(_ card: Card) {
        self.selectedCards.insert(card)
    }

    func toggleSelection(_ card: Card) {
        if self.selectedCards.contains(card) {
            self.selectedCards.remove(card)
        } else {
            self.selectedCards.insert(card)
        }
    }

    func dragAction(entity: GKEntity, point: CGPoint) {
        guard let card = entity as? Card,
              let spriteComponent = card.component(ofType: SpriteComponent.self),
              let interactionComponent = card.component(ofType: InteractionComponent.self) else { return }

        interactionComponent.node.run(
            SKAction.move(to: point, duration: 0)
        )

        spriteComponent.node.run(
            SKAction.move(to: point, duration: 0)
        )

        if !isMoving {
            isMoving = true

            card.removeComponent(ofType: FollowComponent.self)
            card.removeComponent(ofType: MovementComponent.self)

            self.select(card)

            for selectedCard in selectedCards where selectedCard != card {
                selectedCard.addComponent(FollowComponent(target: card))

                let moveComponent = MovementComponent()
                selectedCard.addComponent(moveComponent)

                gameplayManager.moveSystem.addComponent(moveComponent)
            }
        }
    }

    func dropAction(_ entity: GKEntity, point: CGPoint) {
        self.isMoving = false

        guard let card = entity as? Card,
              let spriteComponent = card.component(ofType: SpriteComponent.self) else { return }

        let deltaPoint = spriteComponent.node.position - spriteComponent.origin
        if deltaPoint < 0.1 {
            self.toggleSelection(card)
        } else {
            self.backToOrigin()
        }
    }

    // Temporary function
    private func backToOrigin() {
        for selectedCard in selectedCards {
            gameplayManager.moveSystem.removeComponent(foundIn: selectedCard)

            selectedCard.removeComponent(ofType: FollowComponent.self)
            selectedCard.removeComponent(ofType: MovementComponent.self)

            guard let spriteComponent = selectedCard.component(ofType: SpriteComponent.self),
                  let interactionComponent = selectedCard.component(ofType: InteractionComponent.self) else { return }

            interactionComponent.node.run(
                SKAction.move(to: spriteComponent.origin, duration: 0.3)
            )

            spriteComponent.node.run(
                SKAction.move(to: spriteComponent.origin, duration: 0.3)
            )
        }
    }
}
