//
//  StatusItem.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

//Classe para construir os StatusItems, aka Vida e Reveals.
class StatusItem: GKEntity {
    init(statusType: String, statusValue: Int) {
        super.init()
        self.addComponent(StatusComponent(icon: statusType, value: statusValue, size: CGSize(width: 30, height: 30)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
