//
//  IteractionComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class IteractionComponent: GKComponent {

    private var node: InteractionNode

    init(hitBox: CGSize,
         touchBeganAction: (() -> Void)? = nil, touchEndedAction: (() -> Void)? = nil,
         touchMovedAction: (() -> Void)? = nil) {
        self.node = InteractionNode(size: hitBox)
        self.node.touchBeganAction = touchBeganAction
        self.node.touchEndedAction = touchEndedAction
        self.node.touchBeganAction = touchMovedAction
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAction(touchBeganAction: @escaping () -> Void) {
        self.node.touchBeganAction = touchBeganAction
    }

    func setAction(touchEndedAction: @escaping () -> Void) {
        self.node.touchEndedAction = touchEndedAction
    }

    func setAction(touchMovedAction: @escaping () -> Void) {
        self.node.touchMovedAction = touchMovedAction
    }
}
