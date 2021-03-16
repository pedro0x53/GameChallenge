//
//  GameplayManager.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 15/03/21.
//

import GameplayKit
import SpriteKit

class GameplayManager {

    private var entities = Set<GKEntity>()
    private let scene: SKScene

    // let statusManager: StatusManager
    // let tableManager: TableManager
    // let handManager: HandManager

    init(scene: SKScene) {
        self.scene = scene
    }

    func add(entity: GKEntity) {
        self.entities.insert(entity)

        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            self.scene.addChild(spriteComponent.node)
        }
    }

    func remove(entity: GKEntity) {
        self.entities.remove(entity)

        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            self.scene.removeChildren(in: [spriteComponent.node])
        }
    }

    func drawCards() {}

    func putCardsOnTheTable(cards: [Card]) {}

    func revealCard() {}

    func takeDamage() {}

    func nextLevel() {}

    func gameOver() {}
}
