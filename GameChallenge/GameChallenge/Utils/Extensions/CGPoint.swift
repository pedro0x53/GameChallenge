//
//  CGPoint.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 19/03/21.
//

import SpriteKit

extension CGPoint {
    static func random(_ range: ClosedRange<CGFloat> = 0...1) -> CGPoint {
        return CGPoint(x: CGFloat.random(in: range), y: CGFloat.random(in: range))
    }

    static func randomCornerBased(in frame: CGSize) -> CGPoint {
        let randomX = CGFloat.random(in: 0...frame.width)
        let randomY = CGFloat.random(in: 0...frame.height)
        return CGPoint(x: randomX, y: randomY)
    }

    static func randomCenterBased(in frame: CGSize) -> CGPoint {
        let centerX = frame.width / 2
        let centerY = frame.height / 2
        let randomX = CGFloat.random(in: -centerX...centerX)
        let randomY = CGFloat.random(in: -centerY...centerY)
        return CGPoint(x: randomX, y: randomY)
    }

    func distance(from point: CGPoint = CGPoint(x: 0, y: 0)) -> CGFloat {
        return point.hypotenuse() - self.hypotenuse()
    }

    func hypotenuse() -> CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
}
