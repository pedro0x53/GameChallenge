//
//  LegendComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class LegendComponent: GKComponent {
    let primary: Set<Int>
    let secondary: Set<Int>

    init(primary: Set<Int>, secondary: Set<Int>) {
        self.primary = primary
        self.secondary = secondary
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
