//
//  BoardManager.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 16/03/21.
//

import Foundation

enum SubmitionResult {
    case gold
    case silver
    case bronze
    case wrong
}

class BoardManager {
    let gamePlayManager: GameplayManager
    let legend: Legend
    private(set) var cards = Set<Card>()
    let deck: [Card]

    init(manager: GameplayManager, legend: Legend) {
        gamePlayManager = manager
        self.legend = legend
        self.deck = []
    }

    func add(_ card: Card) {
        self.cards.insert(card)
    }

    func clear(wrongCards: Set<Card>) {
        for card in wrongCards {
            cards.remove(card)
        }
    }

    func drawCards(cards: [Card]) -> [Card] {return []}

    func shuffleDeck() {}

    func checkSubmition() {
        var wrongCards: Set<Card>
//        executeActionFrom(submition: .gold, wrongCards: wrongCards)
//        return .gold
    }

    func executeActionFrom(submition: SubmitionResult, wrongCards: Set<Card> = Set<Card>()) {
        switch submition {
        case .gold, .silver, .bronze:
            print(submition)
        case .wrong:
            clear(wrongCards: wrongCards)
        }
    }
}
