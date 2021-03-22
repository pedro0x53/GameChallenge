//
//  InteractionNode.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 12/03/21.
//

import GameplayKit

class InteractionNode: SKSpriteNode {

    var touchBeganAction: ((CGPoint) -> Void)?
    var touchEndedAction: ((CGPoint) -> Void)?
    var touchMovedAction: ((CGPoint) -> Void)?

    init(size: CGSize, position: CGPoint,
         touchBeganAction: ((CGPoint) -> Void)? = nil,
         touchEndedAction: ((CGPoint) -> Void)? = nil,
         touchMovedAction: ((CGPoint) -> Void)? = nil) {

        super.init(texture: nil, color: .clear, size: size)

        self.isUserInteractionEnabled = true
        self.zPosition = .infinity
        self.position = position

        self.touchBeganAction = touchBeganAction
        self.touchEndedAction = touchEndedAction
        self.touchMovedAction = touchMovedAction
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let action = self.touchBeganAction,
           let firstTouch = touches.first,
           let scene = self.scene {
            action(firstTouch.location(in: scene))
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let action = self.touchMovedAction,
           let firstTouch = touches.first,
           let scene = self.scene {
            action(firstTouch.location(in: scene))
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let action = self.touchEndedAction,
           let firstTouch = touches.first,
           let scene = self.scene {
            action(firstTouch.location(in: scene))
        }
    }
}
