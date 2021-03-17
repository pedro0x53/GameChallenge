//
//  MovementComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 12/03/21.
//

import GameplayKit

class MovementComponent: GKAgent2D, GKAgentDelegate {

    func agentDidUpdate(_ agent: GKAgent) {
        guard let entity = entity,
              let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

        self.position = vector_float2(x: Float(spriteComponent.node.position.x),
                                      y: Float(spriteComponent.node.position.y))
    }

    func agentWillUpdate(_ agent: GKAgent) {
        guard let entity = entity,
              let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

        spriteComponent.node.position = CGPoint(x: CGFloat(self.position.x),
                                                y: CGFloat(self.position.y))
    }

    override func update(deltaTime seconds: TimeInterval) {
        return
    }
}
