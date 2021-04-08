//
//  MainMenuScene.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 24/03/21.
//

import SpriteKit
import Foundation
import AVKit
import CoreMotion

class MainMenuScene: SKScene {

    let startButton: SKSpriteNode = SKSpriteNode(imageNamed: "play-button")
    let soundGameButton: SKSpriteNode = SKSpriteNode(imageNamed: "audio-on-button")
    let gameNameImage = SKSpriteNode(color: .cyan, size: CGSize(width: 200, height: 100))
    lazy var backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "mainmenu-background")
    
    var created = false
    let manager = CMMotionManager()

    var soundPlayer: AVAudioPlayer?
    var backAudioActive: Bool = true

    override func sceneDidLoad() {
    }

    override func didMove(to view: SKView) {
        if created {
            return
        }
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundImage.size = CGSize(width: view.bounds.size.width + 20, height: view.bounds.size.height + 20)
        addChild(backgroundImage)
        backgroundImage.zPosition = -1
        addBackgroundSound()
        //addGameNameImage()
        addStartButton()
        addSoundGameButton()
        created = true

        manager.startGyroUpdates()
        manager.gyroUpdateInterval = 1/60
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { [self] _ in
            if let gyroData = manager.gyroData {

                    let currentXPosition = backgroundImage.position.x
                    var newXPosition = currentXPosition + CGFloat(gyroData.rotationRate.y) * (2/CGFloat.pi)
                    if newXPosition > 10 {
                        newXPosition = 10
                    }
                    if newXPosition < -10 {
                        newXPosition = -10
                    }

                    let currentYPosition = backgroundImage.position.y
                    var newYPosition = currentYPosition + CGFloat(gyroData.rotationRate.x) * (-2/CGFloat.pi)
                    if newYPosition > 10 {
                        newYPosition = 10
                    }
                    if newYPosition < -10 {
                        newYPosition = -10
                    }

                    backgroundImage.position = CGPoint(x: newXPosition, y: newYPosition)
            }
        }

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
            if element == "sound-button" {
                self.toggleStateOfSound()
            }
        }
    }

    func goToGameScene() {
//        self.view?.presentScene(GameScene(size: self.size), transition: .reveal(with: .left, duration: 1))
//        soundPlayer?.pause()
        let pauseScene = PauseScene(size: self.size, currentScene: self)
        pauseScene.pauseGame()
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

    func toggleStateOfSound() {
        backAudioActive = !backAudioActive
        if backAudioActive {
            soundGameButton.texture = SKTexture(imageNamed: "audio-on-button")
            soundPlayer?.play()
        } else {
            soundGameButton.texture = SKTexture(imageNamed: "audio-off-button")
            soundPlayer?.pause()
        }
    }

    func addBackgroundSound() {
        let url = Bundle.main.url(forResource: "background_jogo2", withExtension: "mp3")!

        do {
            try soundPlayer = AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
        } catch {
            return
        }
    }
}
