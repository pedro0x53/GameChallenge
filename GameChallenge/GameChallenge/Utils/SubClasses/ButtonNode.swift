//
//  ButtonNode.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 05/04/21.
//

import SpriteKit

class ButtonNode: InteractionNode {
    let contentNode: SKSpriteNode

    override var isDisabled: Bool {
        didSet {
            self.disable()
        }
    }

    override init(size: CGSize) {
        self.contentNode = SKSpriteNode(texture: nil, color: .clear, size: size)
        self.contentNode.zPosition = 1

        super.init(size: size)

        self.addChild(contentNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func disable() {
        self.run(SKAction.colorize(with: .black, colorBlendFactor: 0.3, duration: 0.3))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentNode.run(SKAction.group([
            SKAction.fadeAlpha(to: 0.8, duration: 0.3),
            SKAction.scale(to: 0.8, duration: 0.3)
        ]))
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentNode.run(SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 0.3),
            SKAction.scale(to: 1, duration: 0.3)
        ]))
        super.touchesEnded(touches, with: event)
    }
}
