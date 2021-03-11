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
        sceneNode.scaleMode = .aspectFill

        // Present the scene
        if let view = self.view as? SKView {
            view.presentScene(sceneNode)

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
