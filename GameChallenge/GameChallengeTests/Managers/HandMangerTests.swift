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

        sut.add(Card())

        let newSize = sut.cards.count

        XCTAssertEqual(oldSize + 1, newSize)
    }

    func test_handManager_remove() {
        let card = Card()
        sut.add(card)

        let oldSize = sut.cards.count

        sut.remove(card)

        let newSize = sut.cards.count

        XCTAssertEqual(oldSize - 1, newSize)
    }

    func test_handManager_selectCard_firstTouchOnCard() {
        let oldSize = sut.selectedCards.count

        sut.selectCard(Card())

        let newSize = sut.selectedCards.count

        XCTAssertEqual(oldSize + 1, newSize)
    }

    func test_handManager_selectCard_secondTouchOnCard() {
        let oldSize = sut.selectedCards.count

        let card = Card()

        sut.selectCard(card)
        sut.selectCard(card)

        let newSize = sut.selectedCards.count

        XCTAssertEqual(oldSize, newSize)
    }

    func test_handManager_dragAction() {
//        let targetCard = Card()
//        let followerCard = Card()

//        targetCard
    }
}
