//
//  HandManager.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 16/03/21.
//

import Foundation

class HandManager {
    private let gameplayManager: GameplayManager

    private(set) var cards = Set<Card>()
    private(set) var selectedCards = Set<Card>()

    init(manager: GameplayManager) {
        self.gameplayManager = manager
    }

    func add(_ card: Card) {
        self.cards.insert(card)
    }

    func remove(_ card: Card) {
        self.cards.remove(card)
    }

    func selectCard(_ card: Card) {
        if selectedCards.contains(card) {
            self.selectedCards.remove(card)
        } else {
            self.selectedCards.insert(card)
        }
    }

    func dragAction(_ card: Card) {
        
    }
}
