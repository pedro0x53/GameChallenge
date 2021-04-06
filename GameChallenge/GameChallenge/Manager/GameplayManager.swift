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
    let scene: SKScene

   // private let statusManager = StatusManager()
    // let tableManager: TableManager
    // let handManager: HandManager

    private let itemTeste = StatusItem(statusType: "Life", statusValue: 2)

    init(scene: SKScene) {
        self.scene = scene
        let statusManager = StatusManager(manager: self)
    }

    func add(entity: GKEntity) {
        self.entities.insert(entity)

        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            self.scene.addChild(spriteComponent.node)
        }

        if let statusComponent = entity.component(ofType: StatusComponent.self) {
                self.scene.removeChildren(in: [statusComponent.node])
                self.scene.addChild(statusComponent.node)
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

    func takeDamage() {

    }

    func nextLevel() {}

    func gameOver() {}
}
