//
//  StatusItem.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

//Classe para construir os StatusItems, aka Vida e Reveals.
class StatusItem: GKEntity {
    var statusValue: Int
    var statusType: Int
    //statusType 0 para Vida, e 1 para Reveals.
    
    init(statusValue: Int, statusType: Int) {
        self.statusValue = statusValue
        self.statusType = statusType
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOne(){
        statusValue+=1
    }
    
    func removeOne(){
        statusValue-=1
    }
}
