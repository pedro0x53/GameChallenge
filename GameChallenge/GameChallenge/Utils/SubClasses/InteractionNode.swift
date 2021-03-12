//
//  InteractionNode.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 12/03/21.
//

import SpriteKit

class InteractionNode: SKSpriteNode {

    var touchBeganAction: (() -> Void)?
    var touchEndedAction: (() -> Void)?
    var touchMovedAction: (() -> Void)?

    init(size: CGSize) {
        super.init(texture: nil, color: .clear, size: size)
        isUserInteractionEnabled = true
        zPosition = .infinity
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let action = self.touchBeganAction {
            action()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let action = self.touchMovedAction {
            action()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let action = self.touchMovedAction {
            action()
        }
    }
}
