//
//  Card.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class Card: GKEntity {
    init(identifier: Int, assetName: String) {
        super.init()
        self.addComponent(CardInfoComponent(identifier: identifier,
                                            assetName: assetName))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
