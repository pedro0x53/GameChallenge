//
//  FollowBehavior.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 12/03/21.
//

import GameplayKit

class FollowComponent: GKComponent {

    let target: GKEntity

    init(target: GKEntity) {
        self.target = target
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
