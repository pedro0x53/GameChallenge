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
    let originRotation: CGFloat
    let originZPosition: CGFloat

    init(assetName: String, size: CGSize, position: CGPoint, rotation: CGFloat, zPosition: CGFloat) {
        self.origin = position
        self.originRotation = rotation
        self.originZPosition = zPosition

        let texture = SKTexture(imageNamed: assetName)
        self.node = SKSpriteNode(texture: texture, color: .clear, size: size)

        self.node.position = position
        self.node.zRotation = rotation
        self.node.zPosition = zPosition

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
