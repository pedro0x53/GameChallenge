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

    public static func moveTo(point: CGPoint, entity: GKEntity, duration: CGFloat = 0) {
        var toMove: [SKNode] = []

        let rotateAction = SKAction.rotate(toAngle: 0, duration: TimeInterval(duration))
        let moveAction = SKAction.move(to: point, duration: TimeInterval(duration))

        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            toMove.append(spriteComponent.node)
        }

        if let interactionComponent = entity.component(ofType: InteractionComponent.self) {
            toMove.append(interactionComponent.node)
        }

        toMove.forEach { (node) in
            node.run(SKAction.group([rotateAction, moveAction]))
        }
    }

    public static func zFall(entity: GKEntity, completion: (() -> Void)? = nil) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

        let fade = SKAction.fadeOut(withDuration: 0.3)
        let shrink = SKAction.scale(to: 0, duration: 0.6)

        if let completion = completion {
            spriteComponent.node.run(SKAction.sequence([
                SKAction.group([fade, shrink]),
                SKAction.run(completion)
            ]))
        } else {
            spriteComponent.node.run(SKAction.group([fade, shrink]))
        }
    }

    public static func drawCardsOut(scene: SKScene, entities: [GKEntity], handler: (() -> Void)?) {
        guard let firstEntity = entities.first,
              let spriteComponent = firstEntity.component(ofType: SpriteComponent.self)
        else {
            if let handler = handler {
                scene.run(SKAction.run(handler))
            }
            return
        }

        let point = CGPoint(x: 0, y: spriteComponent.origin.y)
        let moveToCenter = SKAction.move(to: point, duration: 0.3)
        let rotateToZero = SKAction.rotate(toAngle: 0, duration: 0.3)
        let bounceUp = SKAction.move(to: CGPoint(x: 0, y: spriteComponent.origin.y + 10), duration: 0.2)
        let moveOut = SKAction.move(to: CGPoint(x: 0, y: -1000), duration: 0.5)

        for (index, entity) in entities.enumerated() {
            guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

            spriteComponent.node.run(SKAction.sequence([
                SKAction.group([rotateToZero, moveToCenter]),
                bounceUp, moveOut,
                SKAction.run {
                    if index == entities.endIndex - 1,
                       let handler = handler {
                        scene.run(SKAction.run(handler))
                    }
                }
            ]))
        }
    }

    public static func drawCardsIn(entities: [GKEntity], wait: CGFloat = 0) {
        guard let firstEntity = entities.first,
              let spriteComponent = firstEntity.component(ofType: SpriteComponent.self) else { return }

        let reset = SKAction.group(
            [SKAction.move(to: CGPoint(x: 0, y: -1000), duration: 0),
             SKAction.rotate(toAngle: 0, duration: 0)]
        )

        let wait = SKAction.wait(forDuration: TimeInterval(wait))

        let point = CGPoint(x: 0, y: spriteComponent.origin.y + 10)
        let moveIn = SKAction.move(to: point, duration: 0.5)

        let bounceDown = SKAction.move(to: CGPoint(x: 0, y: point.y - 10), duration: 0.2)

        for entity in entities {
            guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

            let moveToOrigin = SKAction.move(to: spriteComponent.origin, duration: 0.3)
            let rotateToOrigin = SKAction.rotate(toAngle: spriteComponent.originRotation, duration: 0.3)

            spriteComponent.node.run(SKAction.sequence([
                reset,
                SKAction.fadeAlpha(to: 1, duration: 0),
                wait, moveIn, bounceDown,
                SKAction.group([moveToOrigin, rotateToOrigin])
            ]))
        }
    }

    public static func fadeIn(entity: GKEntity, delay: CGFloat = 0, completion: (() -> Void)? = nil) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

        spriteComponent.node.alpha = 0

        if let completion = completion {
            spriteComponent.node.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(delay)),
                SKAction.fadeIn(withDuration: 0.15),
                SKAction.run(completion)
            ]))
        } else {
            spriteComponent.node.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(delay)),
                SKAction.fadeIn(withDuration: 0.15)
            ]))
        }
    }

    public static func fadeOut(entity: GKEntity, delay: CGFloat = 0, completion: (() -> Void)? = nil) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }

        if let completion = completion {
            spriteComponent.node.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(delay)),
                SKAction.fadeOut(withDuration: 0.15),
                SKAction.run(completion)
            ]))
        } else {
            spriteComponent.node.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(delay)),
                SKAction.fadeOut(withDuration: 0.15)
            ]))
        }
    }

    public static func select(_ entity: GKEntity) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self),
              let interactionComponent = entity.component(ofType: InteractionComponent.self) else { return }

        let moveTo = SKAction.moveTo(y: spriteComponent.origin.y + 15, duration: 0.2)

        spriteComponent.node.run(moveTo)
        interactionComponent.node.run(moveTo)
    }

    public static func deselect(_ entity: GKEntity) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self),
              let interactionComponent = entity.component(ofType: InteractionComponent.self) else { return }

        let moveTo = SKAction.moveTo(y: spriteComponent.origin.y, duration: 0.2)

        spriteComponent.node.run(moveTo)
        interactionComponent.node.run(moveTo)
    }
}
