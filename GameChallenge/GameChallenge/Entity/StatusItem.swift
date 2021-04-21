//
//  StatusItem.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

// Classe para construir os StatusItems, aka Vida e Reveals.
class StatusItem: GKEntity {

    public static let statusItemSize = CGSize(width: 30, height: 30)

    init(assetName: String, statusValue: Int) {
        super.init()
        self.addComponent(StatusComponent(icon: assetName, value: statusValue, size: StatusItem.statusItemSize))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
