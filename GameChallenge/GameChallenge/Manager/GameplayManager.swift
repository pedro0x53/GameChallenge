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
    // let tableManager: TableManager
     var handManager: HandManager!

    let moveSystem = GKComponentSystem(componentClass: MovementComponent.self)

    init(scene: SKScene) {
        self.scene = scene
        self.handManager = HandManager(manager: self)
    }

    func add(entity: GKEntity) {
        self.entities.insert(entity)

        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            self.scene.addChild(spriteComponent.node)
        }

        if let interactionComponent = entity.component(ofType: InteractionComponent.self) {
            self.scene.addChild(interactionComponent.node)
        }
    }

    func remove(entity: GKEntity) {
        self.entities.remove(entity)

        var toRemove: [SKNode] = []
        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            toRemove.append(spriteComponent.node)
        }

        if let interactionComponent = entity.component(ofType: InteractionComponent.self) {
            toRemove.append(interactionComponent.node)
        }

        self.scene.removeChildren(in: toRemove)
    }

    func drawCards() {}

    func putCardsOnTheTable(cards: [Card]) {}

    func revealCard() {}

    func takeDamage() {}

    func nextLevel() {}

    func gameOver() {}

    func update(_ deltaTime: CFTimeInterval) {
        moveSystem.update(deltaTime: deltaTime)
    }
}
