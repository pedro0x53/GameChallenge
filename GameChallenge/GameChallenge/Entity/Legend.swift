//
//  Legend.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class Legend: GKEntity {
    init(identifier: Int) {
        super.init()
        self.addComponent(LegendComponent(primary: [1, 2, 3, 4], secondary: [3, 4, 5, 6]))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
