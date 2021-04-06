//
//  GameViewController.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            // Set the scale mode to scale to fit the window
        let sceneNode = GameScene(size: self.view.frame.size)
        let gameplayManager = GameplayManager(scene: sceneNode)

        sceneNode.scaleMode = .aspectFill
        sceneNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        // Present the scene
        if let view = self.view as? SKView {
            view.presentScene(sceneNode)

            view.ignoresSiblingOrder = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
