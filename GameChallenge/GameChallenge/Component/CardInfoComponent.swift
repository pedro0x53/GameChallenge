//
//  CardInfoComponent.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 15/03/21.
//

import GameplayKit

class CardInfoComponent: GKComponent {

    let identifier: Int
    let assetName: String
    
    init(identifier: Int, assetName: String){
        self.identifier = identifier
        self.assetName = assetName
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
