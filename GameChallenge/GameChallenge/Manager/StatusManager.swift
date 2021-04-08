//
//  StatusManager.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 18/03/21.
//

import GameplayKit
import SpriteKit

enum Status {
    case life, reveal
}

class StatusManager {
    let gameplayManager: GameplayManager
    private let lifeItem: StatusItem
    private let revealItem: StatusItem

    init(manager: GameplayManager) {
        gameplayManager = manager
        lifeItem = StatusItem(assetName: "life_icon", statusValue: 3)
        revealItem = StatusItem(assetName: "reveal_icon", statusValue: 2)
        setupStatusItems()
    }

    func setupStatusItems() {
        guard let lifeComponent = lifeItem.component(ofType: StatusComponent.self),
              let revealComponent = revealItem.component(ofType: StatusComponent.self) else { return }

        let xPosition = -gameplayManager.scene.size.width / 2 + 30
        let yPosition = gameplayManager.scene.size.height / 2 - 60

        lifeComponent.node.position = CGPoint(x: xPosition, y: yPosition)
        revealComponent.node.position = CGPoint(x: xPosition + StatusItem.statusItemSize.width + 50, y: yPosition)

        gameplayManager.add(entity: lifeItem)
        gameplayManager.add(entity: revealItem)
    }

    func update(status: Status) -> Bool {
        switch status {
        case .life:
            guard let statusComponent = self.lifeItem.component(ofType: StatusComponent.self) else { return false }
            return (statusComponent.decrease() == 0) ? false : true
        case .reveal:
            guard let statusComponent = self.revealItem.component(ofType: StatusComponent.self) else { return false }
            return (statusComponent.decrease() == -1) ? false : true
        }
    }
}
