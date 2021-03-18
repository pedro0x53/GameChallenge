//
//  BoardManagerTests.swift
//  GameChallengeTests
//
//  Created by Mateus Nobre on 16/03/21.
//

import XCTest
import SpriteKit
@testable import GameChallenge

class BoardManagerTests: XCTestCase {
    let boardManager = BoardManager(manager: GameplayManager(scene: SKScene()), legend: Legend())

    override func setUp() {
//        boardManager
    }

    func test_if_add_card_to_board() {
        let prevCardsCount = boardManager.cards.count
        let newCard = Card(identifier: 100, assetName: "")
        boardManager.add(newCard)
        let currentCardsCount = boardManager.cards.count

        XCTAssertEqual(prevCardsCount, currentCardsCount - 1)
    }

    func test_if_clear_remove_just_wrong_cards() {
        let card1 = Card(identifier: 101, assetName: "")
        let card2 = Card(identifier: 102, assetName: "")
        let card3 = Card(identifier: 103, assetName: "")
        boardManager.add(card1, card2, card3)
        let wrongCards: Set<Card> = [card1, card2]
        let prevCardsCount = boardManager.cards.count
        boardManager.clear(wrongCards: wrongCards)
        let currentCardsCount = boardManager.cards.count

        XCTAssertEqual(prevCardsCount - 2, currentCardsCount)
    }

    func test_if_draw_correct_cards() {}

    override func tearDown() {}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
