//
//  SpeechBubbleNode.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 13/04/21.
//

import SpriteKit

class SpeechBubbleNode: SKSpriteNode {

    let speechLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontName = "KiwiMaru-Medium"
        label.fontSize = 15
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    init() {
//        let texture = SKTexture(imageNamed: "")
        super.init(texture: nil, color: .black, size: Sizes.comment)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.zPosition = 5
        self.addChild(speechLabel)
    }

    func setText(_ text: String) {
        self.speechLabel.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0.3),
            SKAction.run({
                self.speechLabel.text = text
            }),
            SKAction.fadeIn(withDuration: 0.5)
        ]))

        self.run(SKAction.fadeIn(withDuration: 0.5))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.speechLabel.run(SKAction.fadeOut(withDuration: 0.3))

        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 0),
            SKAction.fadeOut(withDuration: 0.5)
        ]))
    }
}
