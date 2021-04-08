//
//  InteractionNode.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 12/03/21.
//

import GameplayKit

enum Event {
    case touchBegan, touchMoved, touchEnded
}

class InteractionNode: SKSpriteNode {

    var isDisabled: Bool = false

    var touchBeganAction: ((CGPoint) -> Void)?
    var touchEndedAction: ((CGPoint) -> Void)?
    var touchMovedAction: ((CGPoint) -> Void)?

    init(size: CGSize) {
        super.init(texture: nil, color: .clear, size: size)
        self.isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAction(for interaction: Event, action: @escaping (CGPoint) -> Void) {
        switch interaction {
        case .touchBegan:
            self.touchBeganAction = action
        case .touchMoved:
            self.touchMovedAction = action
        case .touchEnded:
            self.touchEndedAction = action
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !self.isDisabled,
           let action = self.touchBeganAction,
           let firstTouch = touches.first,
           let scene = self.scene {
            action(firstTouch.location(in: scene))
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if !self.isDisabled,
           let action = self.touchMovedAction,
           let firstTouch = touches.first,
           let scene = self.scene {
            action(firstTouch.location(in: scene))
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if !self.isDisabled,
           let action = self.touchEndedAction,
           let firstTouch = touches.first,
           let scene = self.scene {
            action(firstTouch.location(in: scene))
        }
    }
}
