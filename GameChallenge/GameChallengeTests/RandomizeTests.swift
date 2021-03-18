//
//  RandomizeTests.swift
//  GameChallengeTests
//
//  Created by Mateus Nobre on 18/03/21.
//

import XCTest
@testable import GameChallenge

class RandomizeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let randomize = Randomize()
        randomize.analyzeRandomNums()
        //let num = randomize.generateRandomInt(min: 0, max: 100, seed: 10)
        //print(num)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
