//
//  AnimationManager.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 24/03/21.
//

import SpriteKit
import GameplayKit

class AnimationManager {
    public static func backToOrigin(_ entity: GKEntity) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self),
              let interactionComponent = entity.component(ofType: InteractionComponent.self) else { return }

        let zPosition = spriteComponent.originZPosition
        spriteComponent.node.zPosition = zPosition
        interactionComponent.node.zPosition = zPosition

        let rotateAction = SKAction.rotate(toAngle: spriteComponent.originRotation, duration: 0.3)
        let moveAction = SKAction.move(to: spriteComponent.origin, duration: 0.3)

        interactionComponent.node.run(SKAction.group([rotateAction, moveAction]))
        spriteComponent.node.run(SKAction.group([rotateAction, moveAction]))
    }

    public static func goTo(point: CGPoint, entity: GKEntity) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self),
              let interactionComponent = entity.component(ofType: InteractionComponent.self) else { return }

        let rotateAction = SKAction.rotate(toAngle: 0, duration: 0.3)
        let moveAction = SKAction.move(to: point, duration: 0)

        interactionComponent.node.run(SKAction.group([rotateAction, moveAction]))
        spriteComponent.node.run(SKAction.group([rotateAction, moveAction]))
    }

    public static func zFall(entity: GKEntity, delay: CGFloat = 0) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

        let fade = SKAction.fadeOut(withDuration: 0.3)
        let shrink = SKAction.scale(to: 0, duration: 0.6)

        spriteComponent.node.run(SKAction.sequence([
            SKAction.wait(forDuration: TimeInterval(delay)),
            SKAction.group([fade, shrink])
        ]))
    }
}
