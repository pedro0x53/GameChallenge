//
//  HandMangerTests.swift
//  GameChallengeTests
//
//  Created by Pedro Sousa on 16/03/21.
//

import XCTest
@testable import GameChallenge

class HandMangerTests: XCTestCase {

    var sut: HandManager!

    override func setUp() {
        sut = HandManager(manager: GameplayManager(scene: GameScene()))
    }

    func test_handManager_add() {
        let oldSize = sut.cards.count

        sut.add(Card(identifier: 1, assetName: ""))

        let newSize = sut.cards.count

        XCTAssertEqual(oldSize + 1, newSize)
    }

    func test_handManager_add_fullHand() {
        sut.add(Card(identifier: 1, assetName: ""))
        sut.add(Card(identifier: 2, assetName: ""))
        sut.add(Card(identifier: 3, assetName: ""))
        sut.add(Card(identifier: 4, assetName: ""))

        let card5 = Card(identifier: 5, assetName: "")
        sut.add(card5)

        XCTAssertFalse(sut.cards.contains(card5))
    }

    func test_handManager_remove() {
        let card = Card(identifier: 1, assetName: "")
        sut.add(card)

        let oldSize = sut.cards.count

        sut.remove(card)

        let newSize = sut.cards.count

        XCTAssertEqual(oldSize - 1, newSize)
    }

    func test_handManager_select_firstTouchOnCard() {
        let oldSize = sut.selectedCards.count

        sut.select(Card(identifier: 1, assetName: ""))

        let newSize = sut.selectedCards.count

        XCTAssertEqual(oldSize + 1, newSize)
    }

    func test_handManager_toggleSelection() {
        let card = Card(identifier: 0, assetName: "")

        sut.toggleSelection(card)
        var currentValue = sut.selectedCards.count

        XCTAssertEqual(1, currentValue)

        sut.toggleSelection(card)
        currentValue = sut.selectedCards.count

        XCTAssertEqual(0, currentValue)
    }
}
