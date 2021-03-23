//
//  SpriteComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {
    let node: SKSpriteNode

    let origin: CGPoint

    init(assetName: String, size: CGSize, position: CGPoint) {
        self.origin = position

        let texture = SKTexture(imageNamed: assetName)
        self.node = SKSpriteNode(texture: texture, color: .clear, size: size)
        self.node.position = position

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
