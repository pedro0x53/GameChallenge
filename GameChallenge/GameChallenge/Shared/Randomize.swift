//
//  Randomize.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 18/03/21.
//

import Foundation

class Randomize {

    // Pseudo Random Number Generator
    func generateRandomInt(min: Int = 0, max: Int, seed: Int) -> Int {
        let constA = 423048
        let constC = 12907
        let constM = max - min
        var currentX = seed
        for _ in 0..<100 {
           currentX = (constA * currentX + constC) % constM
            print(currentX)
        }
        return currentX + min
    }

    func analyzeRandomNums() {
        var numCounts = [Int](repeating: 0, count: 100 )
        var numPercents = [Double](repeating: 0.0, count: 100 )
        var maxNumCount = 0
        //var maxNumPos = -1
        for index in 0..<1 {
            let anyConst = 2984023
            
            let num = generateRandomInt(min: 0, max: 100, seed: index+anyConst)
            print(num)
            //numCounts[num] = numCounts[num] + 1
            //if numCounts[num] > maxNumCount {
            //    maxNumCount = numCounts[num]
                //maxNumPos = num
            //}
        }
        for index in 0..<100 {
            numPercents[index] = (Double(numCounts[index])/Double(maxNumCount)) * 100
            print(String(index) + " - " + String(numPercents[index]) + " - " + String(numCounts[index]))
        }
    }

}
