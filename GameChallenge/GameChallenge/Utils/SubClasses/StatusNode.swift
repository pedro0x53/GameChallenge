//
//  StatusNode.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 12/03/21.
//

import SpriteKit

class StatusNode: SKNode {
    private let label = SKLabelNode()
    private let icon: SKSpriteNode

    init(icon: String, label: String, size: CGSize) {
        self.label.text = label
        let texture = SKTexture(imageNamed: icon)
        self.icon = SKSpriteNode(texture: texture, color: .clear, size: size)

        super.init()

        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.addChild(label)
        self.addChild(icon)
    }

    func setLabelText(to text: String) {
        self.label.text = text
    }
}
