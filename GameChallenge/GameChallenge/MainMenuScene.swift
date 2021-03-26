//
//  MainMenuScene.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 24/03/21.
//

import SpriteKit
import Foundation
import UIKit

class MainMenuScene: SKScene {

    let startButton: SKSpriteNode = SKSpriteNode(color: .blue, size: CGSize(width: 96, height: 96))
    let soundGameButton: SKSpriteNode = SKSpriteNode(color: .red, size: CGSize(width: 44, height: 44))
    let gameNameImage = SKSpriteNode(color: .cyan, size: CGSize(width: 200, height: 100))
    lazy var backgroundImage: SKSpriteNode = SKSpriteNode(color: .brown, size: view!.bounds.size)
    override func didMove(to view: SKView) {
        addChild(backgroundImage)
        addGameNameImage()
        addStartButton()
        addSoundGameButton()
    }

    func addStartButton() {
        startButton.name = "start-button"
        startButton.position = CGPoint(x: 0, y: -24)
        addChild(startButton)
    }

    func addSoundGameButton() {
        soundGameButton.anchorPoint = CGPoint(x: 1, y: 1)
        soundGameButton.name = "sound-button"
        addChild(soundGameButton)
        soundGameButton.position = calculateTopRightPosition()
    }

    func addGameNameImage() {
        addChild(gameNameImage)
        gameNameImage.position = CGPoint(x: 0, y: 100)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.location(in: self)
            let element = atPoint(loc).name
            if element == "start-button" {
                goToGameScene()
            }
        }
    }

    func goToGameScene() {
        self.view?.presentScene(GameScene(size: self.size), transition: .reveal(with: .left, duration: 1))
    }

    func calculateTopRightPosition() -> CGPoint {
        let safeAreaTopPadding = calculateSafeAreaBottomAndTopSpacing().top
        let normalPadding = CGFloat(24)
        let yPos = view!.bounds.size.height/2 - safeAreaTopPadding - normalPadding
        let xPos = view!.bounds.size.width/2 - normalPadding
        return CGPoint(x: xPos, y: yPos)
    }

    func calculateSafeAreaBottomAndTopSpacing() -> (bottom: CGFloat, top: CGFloat) {
        var topPadding = CGFloat(0)
        var bottomPadding = CGFloat(0)
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                topPadding = window.safeAreaInsets.top
                bottomPadding = window.safeAreaInsets.bottom
            }
        }
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            topPadding = window.safeAreaInsets.top
            bottomPadding = window.safeAreaInsets.bottom
        }
        return (bottomPadding, topPadding)
    }
}
