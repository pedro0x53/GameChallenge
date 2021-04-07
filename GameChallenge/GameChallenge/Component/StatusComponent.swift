//
//  StatusComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit
import SpriteKit

class StatusComponent: GKComponent {
    private(set) var value: Int

    let node: StatusNode

    init(icon: String, value: Int, size: CGSize) {
        self.value = value
        self.node = StatusNode(icon: icon, label: String(value), size: size)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func decrease() -> Int {
        if self.value > 0 {
            self.value -= 1
            self.node.setLabelText(to: String(value))
            return value
        }
        return -1
    }
}
