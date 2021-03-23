//
//  StatusManager.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 18/03/21.
//

import GameplayKit
import SpriteKit

class StatusManager {
    let gameplayManager: GameplayManager
    var lifeItem: StatusItem
    var revealItem: StatusItem
    
    init(manager: GameplayManager) {
        gameplayManager = manager // Define o gameplayManager como o recebido no init.
        lifeItem = StatusItem(statusValue: 3, statusType:0) // Inicializa um status de Vida com valor 3.
        revealItem = StatusItem(statusValue: 2, statusType:1) // Inicializa um status de Revelar com valor 2.
        return
    }
    
    func wrong(){
        //Chamar a função take damage do gameplay manager
    }
}
