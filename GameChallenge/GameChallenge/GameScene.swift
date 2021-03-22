//
//  GameScene.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var lastUpdateTimeInterval: TimeInterval = 0

    var gameplayManager: GameplayManager!

    override func didMove(to view: SKView) {
        self.gameplayManager = GameplayManager(scene: self)

        let card1 = Card(identifier: 0, assetName: "hand-card")
        self.gameplayManager.handManager.add(card1)

        let card2 = Card(identifier: 1, assetName: "hand-card")
        self.gameplayManager.handManager.add(card2)
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime

        gameplayManager.update(deltaTime)
    }

}
