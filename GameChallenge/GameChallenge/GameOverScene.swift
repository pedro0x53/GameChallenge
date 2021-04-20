//
//  GameOverScene.swift
//  GameChallenge
//
//  Created by David Augusto on 20/04/21.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {

    private lazy var backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "bkg_gameplay")
    private let titleLabel: SKLabelNode = SKLabelNode(text: "Você perdeu!")
    private let subtitleLabel: SKLabelNode = SKLabelNode(text: "Não foi dessa vez, tente novamente.")
    private let homeButton: SKSpriteNode = SKSpriteNode(imageNamed: "home_icon")
    private let retryButton: SKSpriteNode = SKSpriteNode(imageNamed: "retry_icon")
    private var currentGameScene: SKScene

    init(size: CGSize, currentScene: SKScene) {
        self.currentGameScene = currentScene
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundImage.size = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
        addBackgroundImage()
        addTitleLabel()
        addSubtitleLabel()
        addHomeButton()
        addRetryButton()
    }
    private func addBackgroundImage() {
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
    }
    private func addTitleLabel() {
        titleLabel.fontName = "KiwiMaru-Medium"
        titleLabel.fontSize = 45
        titleLabel.color = .white
        titleLabel.position = CGPoint(x: 0, y: 0)
        addChild(titleLabel)
    }
    private func addSubtitleLabel() {
        subtitleLabel.fontName = "KiwiMaru-Medium"
        subtitleLabel.fontSize = 16
        subtitleLabel.color = .white
        subtitleLabel.position = CGPoint(x: 0, y: -40)
        addChild(subtitleLabel)
    }
    private func addHomeButton() {
        homeButton.size = CGSize(width: 70, height: 90)
        homeButton.name = "homeButton"
        homeButton.position = CGPoint(x: -65, y: -150)
        addChild(homeButton)
    }
    private func addRetryButton() {
        retryButton.size = CGSize(width: 70, height: 90)
        retryButton.name = "retryButton"
        retryButton.position = CGPoint(x: 65, y: -150)
        addChild(retryButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.location(in: self)
            let element = atPoint(loc).name
            switch element {
            case "homeButton":
                backToHome()
            case "retryButton":
                retry()
            default:
                return
            }
        }
    }

    private func retry() {
        let gameScene = GameScene(size: self.size)
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(gameScene, transition: .reveal(with: .up, duration: 1))
        SongsManager.shared.setCurrentSong(sceneSong: .gamePlay)
        SongsManager.shared.playSong()
    }

    private func backToHome() {
        self.view?.presentScene(MainMenuScene(size: self.size), transition: .reveal(with: .right, duration: 1))
    }
}
