//
//  InteractionComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class InteractionComponent: GKComponent {

    private(set) var node: InteractionNode!

    private var touchBeganAction: ((GKEntity, CGPoint) -> Void)?
    private var touchEndedAction: ((GKEntity, CGPoint) -> Void)?
    private var touchMovedAction: ((GKEntity, CGPoint) -> Void)?

    init(hitBox: CGSize,
         touchBeganAction: ((GKEntity, CGPoint) -> Void)? = nil,
         touchEndedAction: ((GKEntity, CGPoint) -> Void)? = nil,
         touchMovedAction: ((GKEntity, CGPoint) -> Void)? = nil) {

        self.touchBeganAction = touchBeganAction
        self.touchEndedAction = touchEndedAction
        self.touchMovedAction = touchMovedAction

        super.init()

        self.node = InteractionNode(size: hitBox)
        self.node.setAction(for: .touchBegan, action: self.touchBegan)
        self.node.setAction(for: .touchMoved, action: self.touchMoved)
        self.node.setAction(for: .touchEnded, action: self.touchEnded)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAction(for interaction: Event, action: @escaping (GKEntity, CGPoint) -> Void) {
        switch interaction {
        case .touchBegan:
            self.touchBeganAction = action
        case .touchMoved:
            self.touchMovedAction = action
        case .touchEnded:
            self.touchEndedAction = action
        }
    }

    func touchBegan(point: CGPoint) {
        guard let entity = self.entity,
              let action = self.touchBeganAction else { return }

        action(entity, point)
    }

    func touchMoved(point: CGPoint) {
        guard let entity = self.entity,
              let action = self.touchMovedAction else { return }

        action(entity, point)
    }

    func touchEnded(point: CGPoint) {
        guard let entity = self.entity,
              let action = self.touchEndedAction else { return }

        action(entity, point)
    }
}
