//
//  LegendFoundScene.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 21/04/21.
//

import Foundation
//
//  GameOverScene.swift
//  GameChallenge
//
//  Created by David Augusto on 20/04/21.
//

import Foundation
import SpriteKit

class LegendFoundScene: SKScene {

    private lazy var backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "bkg_gameplay")
    private lazy var legendCard: SKSpriteNode = SKSpriteNode(imageNamed: "legend_saci")
    private lazy var homeButton: SKSpriteNode = SKSpriteNode(imageNamed: "home_icon")
    private let congratulationsLabel: SKLabelNode = SKLabelNode(text: "Parabéns!")
    private let legendNameAnnouncementLabel: SKLabelNode = SKLabelNode(text: "Vocë encontrou o Saci!")
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
        addHomeButton()
        addCongratulationsLabel()
        addLegendAnnouncementLabel()
        addLegendCard()

    }
    private func addBackgroundImage() {
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
    }
    private func addCongratulationsLabel() {
        congratulationsLabel.fontName = "KiwiMaru-Medium"
        congratulationsLabel.fontSize = 45
        congratulationsLabel.color = .white
        congratulationsLabel.position = CGPoint(x: 0, y: 300)
        addChild(congratulationsLabel)
    }
    private func addLegendAnnouncementLabel() {
        legendNameAnnouncementLabel.fontName = "KiwiMaru-Medium"
        legendNameAnnouncementLabel.fontSize = 16
        legendNameAnnouncementLabel.color = .white
        legendNameAnnouncementLabel.position = CGPoint(x: 0, y: 260)
        addChild(legendNameAnnouncementLabel)
    }

    private func addLegendCard(){
        legendCard.size = CGSize(width: 280, height: 360)
        legendCard.name = "legendCard"
        legendCard.position = CGPoint(x: 0, y: 20)
        addChild(legendCard)
    }

    private func addHomeButton() {
        homeButton.size = CGSize(width: 70, height: 90)
        homeButton.name = "homeButton"
        homeButton.position = CGPoint(x: 0, y: -250)
        addChild(homeButton)
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
