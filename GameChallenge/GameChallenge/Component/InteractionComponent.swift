//
//  InteractionComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class InteractionComponent: GKComponent {

    private var node: InteractionNode

    private var touchBeganAction: ((_ sender: GKEntity) -> Void)?
    private var touchEndedAction: ((_ sender: GKEntity) -> Void)?
    private var touchMovedAction: ((_ sender: GKEntity) -> Void)?

    init(hitBox: CGSize,
         touchBeganAction: ((_ sender: GKEntity) -> Void)? = nil,
         touchEndedAction: ((_ sender: GKEntity) -> Void)? = nil,
         touchMovedAction: ((_ sender: GKEntity) -> Void)? = nil) {

        self.node = InteractionNode(size: hitBox)

        self.touchBeganAction = touchBeganAction
        self.touchEndedAction = touchEndedAction
        self.touchMovedAction = touchMovedAction

        super.init()

        self.node.touchBeganAction = self.touchBegan
        self.node.touchEndedAction = self.touchEnded
        self.node.touchBeganAction = self.touchMoved
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

    func touchBegan() {
        if let action = self.touchBeganAction,
           let entity = self.entity {
            action(entity)
        }
    }

    func touchEnded() {
        // drop animation
        if let action = self.touchEndedAction,
           let entity = self.entity {
            action(entity)
        }
    }

    func touchMoved() {
        if let action = self.touchMovedAction,
           let entity = self.entity {
            action(entity)
        }
    }
}
