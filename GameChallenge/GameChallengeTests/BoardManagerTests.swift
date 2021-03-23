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
        boardManager.clear(wrongCards: boardManager.cards)
        let prevCardsCount = boardManager.cards.count
        let newCard = Card(identifier: 100, assetName: "")
        boardManager.add(newCard)
        let currentCardsCount = boardManager.cards.count
        XCTAssertEqual(prevCardsCount, currentCardsCount - 1)

        boardManager.maxCardsBoard = 4

        boardManager.add(Card(identifier: 0, assetName: ""))
        boardManager.add(Card(identifier: 0, assetName: ""))
        boardManager.add(Card(identifier: 0, assetName: ""))
        boardManager.add(Card(identifier: 0, assetName: ""))
        boardManager.add(Card(identifier: 0, assetName: ""))
        boardManager.add(Card(identifier: 0, assetName: ""))

        XCTAssertEqual(boardManager.cards.count, 4)
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

    func test_calculate_pontuation_and_wrong_card() {
        let legend = Legend()
        let emptyCards = Set<Card>()
        var result = boardManager.calculatePontuationAndWrongCards(legend: legend, cards: emptyCards)
        XCTAssertEqual(result.0, 0)
        XCTAssertEqual(result.1, Set<Card>())

        let legendComponent = LegendComponent(primary: [0, 1, 2, 3], secundary: [4, 5, 6, 7])
        legend.addComponent(legendComponent)
        let allPrimaryCards: Set<Card> = [
            Card(identifier: 0, assetName: ""),
            Card(identifier: 1, assetName: ""),
            Card(identifier: 2, assetName: ""),
            Card(identifier: 3, assetName: "")
        ]
        result = boardManager.calculatePontuationAndWrongCards(legend: legend, cards: allPrimaryCards)
        XCTAssertEqual(result.0, 16)
        XCTAssertEqual(result.1, Set<Card>())

        let secundaryAndPrimaryCards: Set<Card> = [
            Card(identifier: 0, assetName: ""),
            Card(identifier: 1, assetName: ""),
            Card(identifier: 4, assetName: ""),
            Card(identifier: 5, assetName: "")
        ]

        result = boardManager.calculatePontuationAndWrongCards(legend: legend, cards: secundaryAndPrimaryCards)
        XCTAssertEqual(result.0, 10)
        XCTAssertEqual(result.1, Set<Card>())

        let wrongCard1 = Card(identifier: 12, assetName: "")
        let wrongCard2 = Card(identifier: 13, assetName: "")
        let wrong2CardsAnd2PrimaryCards: Set<Card> = [
            Card(identifier: 0, assetName: ""),
            Card(identifier: 1, assetName: ""),
            wrongCard1,
            wrongCard2
        ]
        result = boardManager.calculatePontuationAndWrongCards(legend: legend, cards: wrong2CardsAnd2PrimaryCards)
        XCTAssertEqual(result.0, 8)
        XCTAssertEqual(result.1, [wrongCard2, wrongCard1])
    }

    func test_if_excution_submission_action_works() {
        let wrongCard1 = Card(identifier: 10, assetName: "")
        let wrongCard2 = Card(identifier: 11, assetName: "")
        boardManager.add(wrongCard1, wrongCard2)
        XCTAssertTrue(boardManager.cards.contains(wrongCard1))
        XCTAssertTrue(boardManager.cards.contains(wrongCard2))
        boardManager.executeActionFrom(submition: .wrong, wrongCards: [wrongCard1, wrongCard2])
        XCTAssertFalse(boardManager.cards.contains(wrongCard1))
        XCTAssertFalse(boardManager.cards.contains(wrongCard2))
    }

    func test_if_add_card_to_down_deck_works() {
        let card1 = Card(identifier: 1, assetName: "")
        let card2 = Card(identifier: 2, assetName: "")
        let card3 = Card(identifier: 3, assetName: "")
        let card4 = Card(identifier: 4, assetName: "")
        let card5 = Card(identifier: 5, assetName: "")
        let card6 = Card(identifier: 6, assetName: "")
        let card7 = Card(identifier: 7, assetName: "")
        boardManager.deck = [card1, card2, card3, card4, card5, card6, card7]
        boardManager.addCardToDownDeck(card7)
        XCTAssertEqual(boardManager.deck, [card7, card1, card2, card3, card4, card5, card6])
    }

    func test_if_draw_cards_works() {
        boardManager.deck = []
        var result = boardManager.drawCards(amount: 3)

        let card1 = Card(identifier: 1, assetName: "")
        let card2 = Card(identifier: 2, assetName: "")
        let card3 = Card(identifier: 3, assetName: "")
        let card4 = Card(identifier: 4, assetName: "")
        let card5 = Card(identifier: 5, assetName: "")
        let card6 = Card(identifier: 6, assetName: "")
        let card7 = Card(identifier: 7, assetName: "")
        boardManager.deck = [card1, card2, card3, card4, card5, card6, card7]
        result = boardManager.drawCards(amount: 3)
        XCTAssertEqual(result, [card7, card6, card5])
    }

    func test_position_calculate() {
        boardManager.clear(wrongCards: boardManager.cards)
        boardManager.maxCardsBoard = 2
        boardManager.startPoint = CGPoint(x: 10, y: 1000)
        boardManager.cardHeight = CGFloat(200)
        boardManager.spaceBetweenCards = CGFloat(15)
        let firstCardPosition = boardManager.calcBoardNewCardPosition()
        boardManager.add(Card(identifier: 0, assetName: ""))
        let calculatedSecondCardPosition = boardManager.calcBoardNewCardPosition()
        let trueSecondCardPosition = CGPoint(x: boardManager.startPoint.x,
                                             y: boardManager.startPoint.y - (CGFloat(15) + boardManager.cardHeight))

        XCTAssertEqual(CGPoint(x: 10, y: 1000), firstCardPosition)
        XCTAssertEqual(trueSecondCardPosition, calculatedSecondCardPosition)
    }

    override func tearDown() {}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
