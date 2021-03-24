//
//  StatusItem.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

//Classe para construir os StatusItems, aka Vida e Reveals.
class StatusItem: GKEntity {
    init(statusValue: Int, statusType: Int) {
        super.init()
        self.addComponent(StatusComponent(icon: "Coracao", value: 3, size: CGSize(width: 50, height: 40)))
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
