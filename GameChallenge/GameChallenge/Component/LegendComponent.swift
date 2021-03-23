//
//  LegendComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class LegendComponent: GKComponent {
    var primary: Set<Int>
    var secundary: Set<Int>

    init(primary: Set<Int>, secundary: Set<Int>) {
        self.primary = primary
        self.secundary = secundary
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
