//
//  LegendComponent.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class LegendComponent: GKComponent {
    var solution: Set<String>

    init(solution: Set<String>) {
        self.solution = solution
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
