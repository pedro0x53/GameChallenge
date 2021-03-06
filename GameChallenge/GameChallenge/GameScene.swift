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
    private var gameStarted: Bool = false

    var gameplayManager: GameplayManager!

    override func didMove(to view: SKView) {

        if gameStarted { return }

        self.gameplayManager = GameplayManager(scene: self)

        let bkgTexture = SKTexture(imageNamed: "bkg_gameplay")
        let backgroundNode = SKSpriteNode(texture: bkgTexture, size: self.size)
        backgroundNode.zPosition = 0
        self.addChild(backgroundNode)

        let pauseBtnTexture = SKTexture(imageNamed: "pause_icon")
        let pauseIcon = SKSpriteNode(texture: pauseBtnTexture, size: pauseBtnTexture.size())
        pauseIcon.setScale(0.5)
        let pauseButton = ButtonNode(size: pauseIcon.size)
        pauseButton.setAction(for: .touchEnded) { _ in self.showPauseMenu() }
        pauseButton.contentNode.addChild(pauseIcon)
        pauseButton.position = CGPoint(x: self.size.width / 2 - pauseButton.size.width / 2 - 20,
                                      y: self.size.height / 2 - pauseButton.size.height / 2 - 20)
        self.addChild(pauseButton)

        let revealTexture = SKTexture(imageNamed: "reveal_button_icon")
        let revealNode = SKSpriteNode(texture: revealTexture, size: revealTexture.size())
        revealNode.setScale(0.4)
        let revealButton = ButtonNode(size: revealNode.size)
        revealButton.setAction(for: .touchEnded, action: self.gameplayManager.revealCard)
        revealButton.contentNode.addChild(revealNode)
        revealButton.position = CGPoint(x: -Sizes.buttons.width / 2 - 30, y: -130)
        self.addChild(revealButton)

        let drawTexture = SKTexture(imageNamed: "draw_icon")
        let drawNode = SKSpriteNode(texture: drawTexture, size: drawTexture.size())
        drawNode.setScale(0.4)
        let drawButton = ButtonNode(size: drawNode.size)
        drawButton.setAction(for: .touchEnded, action: self.gameplayManager.drawCards)
        drawButton.contentNode.addChild(drawNode)
        drawButton.position = CGPoint(x: Sizes.buttons.width / 2 + 30, y: -130)
        self.addChild(drawButton)

        self.gameStarted = true
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime

        gameplayManager.update(deltaTime)
    }

    func legendFound() {
        let legendFoundScene = LegendFoundScene(size: self.size, currentScene: self)
        legendFoundScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(legendFoundScene, transition: .push(with: .left, duration: 1))
        SongsManager.shared.setCurrentSong(sceneSong: .mainMenu)
        SongsManager.shared.playSong()
    }
    
    func goToGameOverScene() {
        let gameOverScene = GameOverScene(size: self.size, currentScene: self)
        gameOverScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(gameOverScene, transition: .push(with: .left, duration: 1))
        SongsManager.shared.setCurrentSong(sceneSong: .mainMenu)
        SongsManager.shared.playSong()
    }

    func showPauseMenu() {
        let pauseScene = PauseScene(size: self.size, currentScene: self)
        pauseScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(pauseScene, transition: .push(with: .down, duration: 1))
    }
}
