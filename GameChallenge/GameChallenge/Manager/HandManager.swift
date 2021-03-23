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

    private(set) var cards: [Card] = []
    private(set) var selectedCards: [Card] = []

    private var isMoving: Bool = false

    private let responsiver = Responsiver(designSize: CGSize(width: 390, height: 844))

    private let cardSize = CGSize(width: 100, height: 140)

    init(manager: GameplayManager) {
        self.gameplayManager = manager
    }

    func add(_ card: Card) {
        if self.cards.count < 4 && !cards.contains(card) {
            self.cards.append(card)
        }
    }

    func render() {
        for (index, card) in cards.enumerated() {
            guard let cardComponent = card.component(ofType: CardInfoComponent.self) else { return }

            let currentCardSize = responsiver.responsiveSize(for: self.cardSize)

            let position = self.position(at: index)
            let rotation = self.rotation(at: index)

            let spriteComponent = SpriteComponent(assetName: cardComponent.assetName,
                                                  size: currentCardSize,
                                                  position: position)
            spriteComponent.node.zRotation = rotation
            spriteComponent.node.zPosition = CGFloat(index + 10)

            card.addComponent(spriteComponent)

            let interactionComponent = InteractionComponent(hitBox: currentCardSize,
                                                            position: position,
                                                            touchEndedAction: self.dropAction,
                                                            touchMovedAction: self.dragAction)
            interactionComponent.node.zRotation = rotation
            interactionComponent.node.zPosition = CGFloat(index + 11)
            card.addComponent(interactionComponent)

            gameplayManager.add(entity: card)
        }
    }

    func remove(_ card: Card) {
        guard let index = self.selectedCards.firstIndex(of: card) else { return }
        self.cards.remove(at: index)
    }

    func select(_ card: Card) {
        if !selectedCards.contains(card) {
            selectedCards.append(card)
        }
    }

    func toggleSelection(_ card: Card) {
        if self.selectedCards.contains(card),
           let index = self.selectedCards.firstIndex(of: card) {
            self.selectedCards.remove(at: index)
        } else {
            self.selectedCards.append(card)
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

    // Temporary functions
    // Back to initial point animation
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

    // Get initial point
    private func position(at index: Int) -> CGPoint {
        let sceneSize = self.gameplayManager.scene.size
        let currentCardSize = responsiver.responsiveSize(for: CGSize(width: 100, height: 140))

        var positionX: CGFloat = currentCardSize.width * 1.5 - 44
        var positionY: CGFloat = (-sceneSize.height / 2) + 30 + currentCardSize.height

        if index == 0 {
            positionX *= -1
        }

        if index == 1 || index == 2 {
            positionY += 4

            positionX = currentCardSize.width / 2 - 11

            if index == 1 {
                positionX *= -1
            }
        }

        return CGPoint(x: positionX, y: positionY)
    }

    private func rotation(at index: Int) -> CGFloat {
        var rotation: CGFloat = 4 * radian

        if index == 3 {
            rotation *= -1
        }

        if index == 1 || index == 2 {
            rotation = 2 * radian

            if index == 2 {
                rotation *= -1
            }
        }

        return rotation
    }
}
