//
//  Legend.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 11/03/21.
//

import GameplayKit

class Legend: GKEntity {

    let identifier: Int

    init?(identifier: Int) {
        self.identifier = identifier

        super.init()

        if identifier >= 0 && identifier < GameData.legends.count {
            let firstLegend = GameData.legends[identifier]

            guard let primarySolution = firstLegend["primarySolution"] as? [Int] else {
                print("Lenda com ID \(identifier) não possui uma solução definida.")
                return nil
            }

            self.addComponent(LegendComponent(primary: Set(primarySolution), secondary: []))
            
        } else {
            print("Lenda com ID \(identifier) não definida.")
            return nil
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
