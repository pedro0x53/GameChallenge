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
        lifeItem = StatusItem(statusType: "Life", statusValue: 3) // Inicializa um status de Vida com valor 3.
        revealItem = StatusItem(statusType: "Reveal", statusValue: 2) // Inicializa um status de Revelar com valor 2.
        print("initou status manager")
        setupStatusItems()
        //print(scene.size.width)
        print(gameplayManager.scene.size.width)
        return
    }
    
    func setupStatusItems(){
        //lifeItem.component(ofType: StatusComponent?).node.position.x = 50
    }
}
