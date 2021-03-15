//
//  CoreDataStackTest.swift
//  GameChallengeTests
//
//  Created by Gustavo Lemos on 15/03/21.
//

import XCTest
@testable import GameChallenge

class CoreDataStackTest: XCTestCase {

    func test_CoreDataStack_saveContext_true() {
        let sut = CoreDataStack.inMemory
        let result = sut.saveContext()
        XCTAssertTrue(result)
    }
}
