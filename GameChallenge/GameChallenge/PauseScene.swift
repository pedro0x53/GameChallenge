//
//  PauseScene.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 06/04/21.
//

import Foundation
import SpriteKit

class PauseScene: SKScene {
    
    private lazy var backgroundImage: SKSpriteNode = SKSpriteNode(color: .brown, size: view!.bounds.size)
    private let exitGameButton: SKSpriteNode = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 60))
    private let backToGameButton: SKSpriteNode = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 60))
    private var currentGameScene: SKScene

    init(size: CGSize, currentScene: SKScene) {
        self.currentGameScene = currentScene
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pauseGame() {
        self.currentGameScene.view?.presentScene(self, transition: .moveIn(with: .up, duration: 1))
    }

    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addBackgroundImage()
        addBackToGameButton()
        addExitGameButton()
    }

    private func addBackToGameButton() {
        backToGameButton.name = "back-game-button"
        backToGameButton.position = CGPoint(x: 0, y: 48)
        addChild(backToGameButton)
    }

    private func addExitGameButton() {
        exitGameButton.name = "exit-game-button"
        exitGameButton.position = CGPoint(x: 0, y: -48)
        addChild(exitGameButton)
    }

    private func addBackgroundImage() {
        addChild(backgroundImage)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.location(in: self)
            let element = atPoint(loc).name
            switch element {
            case "back-game-button":
                backToGame()
            case "exit-game-button":
                exitGame()
            default:
                return
            }
        }
    }

    private func backToGame() {
        self.view?.presentScene(currentGameScene, transition: .reveal(with: .up, duration: 1))
    }

    private func exitGame() {
        self.view?.presentScene(MainMenuScene(size: self.size), transition: .reveal(with: .right, duration: 1))
    }

}
