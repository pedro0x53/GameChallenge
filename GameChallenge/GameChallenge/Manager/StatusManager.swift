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
        setupStatusItems()
        return
    }
    
    func setupStatusItems(){
        lifeItem.component(ofType: StatusComponent.self)?.node.position.x = -gameplayManager.scene.size.width/2+30
        lifeItem.component(ofType: StatusComponent.self)?.node.position.y = gameplayManager.scene.size.height/2-30

        revealItem.component(ofType: StatusComponent.self)?.node.position.x = -30
        revealItem.component(ofType: StatusComponent.self)?.node.position.y = -30
        
        gameplayManager.add(entity: lifeItem)
        gameplayManager.add(entity: revealItem)
        print (lifeItem.component(ofType: StatusComponent.self)?.node.position.x)
        
    }
}
