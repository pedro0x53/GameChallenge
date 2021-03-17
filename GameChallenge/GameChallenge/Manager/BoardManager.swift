//
//  BoardManager.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 16/03/21.
//

import Foundation
import GameplayKit

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
    var deck: [Card]

    init(manager: GameplayManager, legend: Legend) {
        gamePlayManager = manager
        self.legend = legend
        self.deck = []
        tempGenerateCards(num: 20)
        shuffleDeck()
    }

    //Funcao temporaria, remover quando as cartas  vierem
    // de outro Manager
    func tempGenerateCards(num: Int) {
        for _ in 0..<num {
            let card = Card()
            self.deck.append(card)
        }
    }

    func add(_ cards: Card...) {
        for card in cards {
            self.cards.insert(card)
        }
    }

    func clear(wrongCards: Set<Card>) {
        for card in wrongCards {
            cards.remove(card)
        }
    }

    func drawCards(amount: Int) -> [Card] {
        var returnedCards: [Card] = []
        for _ in 0..<amount {
            let lastCard = self.deck.removeLast()
            returnedCards.append(lastCard)
            addCardToDownDeck(lastCard)
        }
        return returnedCards
    }

    func addCardToDownDeck(_ card: Card) {
        var tempDeck: [Card] = []
        tempDeck.append(card)
        tempDeck.append(contentsOf: self.deck)
    }

    func shuffleDeck() {
        var newDeck: [Card] = []
        let initialCardsCount = self.deck.count
        for _ in 0..<initialCardsCount {
            let randomPosition = Int.random(in: 0..<self.deck.count)
            newDeck.append(self.deck[randomPosition])
            self.deck.remove(at: randomPosition)
        }
        self.deck = newDeck
    }

    func checkSubmition() {
//        var wrongCards: Set<Card>
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
