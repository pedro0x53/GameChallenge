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
        let pauseButton = ButtonNode(size: CGSize(width: 50, height: 50))
        pauseButton.position = CGPoint(x: self.size.width / 2 - pauseButton.size.width / 2 - 30,
                                      y: self.size.height / 2 - pauseButton.size.height / 2 - 30)
//        pauseButton.setAction(for: .touchEnded, action: )
        self.addChild(pauseButton)
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime

        gameplayManager.update(deltaTime)
    }

}
