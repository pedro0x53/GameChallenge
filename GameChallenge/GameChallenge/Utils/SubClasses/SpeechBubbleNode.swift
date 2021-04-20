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
        label.fontColor = .black
        label.fontSize = 15
        label.numberOfLines = 3
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    weak var delegate: SpeechBubbleDelegate?

    init() {
        let texture = SKTexture(imageNamed: "speechBubble")
        super.init(texture: texture, color: .clear, size: Sizes.comment)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.isUserInteractionEnabled = true
        self.zPosition = 5
        speechLabel.position = CGPoint(x: 0, y: 0)
        self.addChild(speechLabel)
    }

    func setText(_ text: String) {
        if self.speechLabel.text == text {
            return
        }

        self.speechLabel.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0.3),
            SKAction.run({
                self.speechLabel.text = text
            }),
            SKAction.fadeIn(withDuration: 0.3)
        ]))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let delegate = self.delegate {
            self.run(SKAction.run(delegate.nextLine))
        }
    }
}
