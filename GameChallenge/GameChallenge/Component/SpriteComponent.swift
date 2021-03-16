//
//  SpriteComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {
    var node: SKSpriteNode

    init(assetName: String, size: CGSize) {
        let texture = SKTexture(imageNamed: assetName)
        self.node = SKSpriteNode(texture: texture, color: .clear, size: size)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
