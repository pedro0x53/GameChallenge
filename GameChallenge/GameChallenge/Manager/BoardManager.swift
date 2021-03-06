//
//  BoardManager.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 16/03/21.
//

import Foundation
import GameplayKit
import SpriteKit

enum SubmitionResult {
    case gold
    case silver
    case bronze
    case wrong
}

class BoardManager {
    let gamePlayManager: GameplayManager
    private var legend: Legend

    private(set) var cards: [Card] = []
    var deck: [Card]

    private let spaceBetweenCards: CGFloat = 10
    private var currentPosition: CGPoint = CGPoint(x: 0, y: 0)

    private let goldPontuation = 16
    private let silverPontuation = 13

    init(manager: GameplayManager, legend: Legend) {
        gamePlayManager = manager
        self.legend = legend
        self.deck = []

        setupLegend()

        generateDeck()
        shuffleDeck()

        setupInitialOffset()
    }

    private func setupLegend() {
        let positionX: CGFloat = -Sizes.boardCard.width + 10
        let positionY: CGFloat = (gamePlayManager.scene.size.height - Sizes.legend.height) / 2 -
            100 / Sizes.responsiver.sizeProportion

        let spriteComponent = SpriteComponent(assetName: "legend_default",
                                              size: Sizes.legend,
                                              position: CGPoint(x: positionX, y: positionY),
                                              rotation: 0,
                                              zPosition: 1)

        spriteComponent.node.position = CGPoint(x: 0, y: positionY)

        legend.addComponent(spriteComponent)

        self.gamePlayManager.add(entity: legend)
    }

    private func setupInitialOffset() {
        guard let legendSprite = self.legend.component(ofType: SpriteComponent.self) else { return }
        self.currentPosition.x = (Sizes.legend.width + Sizes.boardCard.width + 35) / 2 - Sizes.boardCard.width
        self.currentPosition.y = legendSprite.origin.y + (Sizes.boardCard.height * 2.5 + spaceBetweenCards * 2.5)
    }

    func isOverLegend(point: CGPoint) -> Bool {
        guard let spriteComponent = self.legend.component(ofType: SpriteComponent.self) else { return false }
        return spriteComponent.node.frame.contains(point)
    }

    func generateDeck() {
        guard let legendComponent = self.legend.component(ofType: LegendComponent.self) else { return }

        for rawData in GameData.deck {
            if let identifier = rawData["identifier"] as? Int,
               let assetName = rawData["assetName"] as? String {
                self.deck.append(Card(identifier: identifier, assetName: assetName))

                if legendComponent.primary.contains(identifier) {
                    self.deck.append(Card(identifier: identifier, assetName: assetName))
                }
            }
        }
    }

    @discardableResult
    func add(_ card: Card) -> Bool {
        if self.cards.count >= 4 { return false }

        if self.cards.isEmpty,
           let legendSprite = self.legend.component(ofType: SpriteComponent.self) {
            legendSprite.node.run(SKAction.moveTo(x: legendSprite.origin.x, duration: 0.5))
        }

        guard let cardInfoComponent = card.component(ofType: CardInfoComponent.self) else { return false }

        let newCard = Card(identifier: cardInfoComponent.identifier, assetName: cardInfoComponent.assetName)

        AnimationManager.zFall(entity: card) { [unowned self] in
            gamePlayManager.remove(entity: card)
        }

        if alreadyOnTheBoard(identifier: cardInfoComponent.identifier) { return true }

        self.cards.append(newCard)

        newCard.addComponent(SpriteComponent(assetName: cardInfoComponent.assetName,
                                             size: Sizes.boardCard,
                                             position: calcBoardNewCardPosition(),
                                             rotation: 0,
                                             zPosition: 2))
        self.gamePlayManager.add(entity: newCard)
        AnimationManager.fadeIn(entity: newCard, delay: 0.3) {
            if self.cards.count == 4 {
                self.checkSubmition()
            }
        }

        return true
    }

    func calcBoardNewCardPosition() -> CGPoint {
        currentPosition.y -= (Sizes.boardCard.height + spaceBetweenCards)
        return currentPosition
    }

    func clear(wrongCards: Set<Card>) {
        for card in wrongCards {
            AnimationManager.fadeOut(entity: card)
            if let index = cards.firstIndex(of: card) {
                cards.remove(at: index)
            }
        }
        repositionRemainCards()

        if self.cards.isEmpty,
           let legendSprite = self.legend.component(ofType: SpriteComponent.self) {
            legendSprite.node.run(SKAction.moveTo(x: 0, duration: 0.5))
        }
    }

    func repositionRemainCards() {
        setupInitialOffset()
        for card in cards {
            AnimationManager.moveTo(point: calcBoardNewCardPosition(), entity: card, duration: 0.3)
        }
    }

    func alreadyOnTheBoard(identifier: Int) -> Bool {
        let boardIdentifiers: [Int] = self.cards.compactMap { card in
            guard let cardInfo = card.component(ofType: CardInfoComponent.self) else { return nil }
            return cardInfo.identifier
        }

        return boardIdentifiers.contains(identifier)
    }

    func drawCards(cards: [Card]) -> [Card] {
        self.deck.insert(contentsOf: cards.reversed(), at: 0)
        let returnedCards = self.deck[self.deck.count-4...self.deck.count-1]
        self.deck.removeLast(4)
        return [Card](returnedCards)
    }

    func removeFirstCardOfDeck() -> Card {
        return self.deck.remove(at: self.deck.count - 1)
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
        if self.cards.count == 4 {
            let pontuationAndWrongCard = calculatePontuationAndWrongCards(legend: self.legend, cards: Set(self.cards))
            if pontuationAndWrongCard.1.count > 0 {
                executeActionFrom(submition: .wrong, wrongCards: pontuationAndWrongCard.1)
                return
            }
            let pontuation = pontuationAndWrongCard.0
            if pontuation>=goldPontuation {
                executeActionFrom(submition: .gold)
                return
            } else if pontuation>=silverPontuation {
                executeActionFrom(submition: .silver)
                return
            } else {
                executeActionFrom(submition: .bronze)
                return
            }
        }
    }

    func calculatePontuationAndWrongCards(legend: Legend, cards: Set<Card>) -> (Int, Set<Card>) {
        guard let legendComponent = legend.component(ofType: LegendComponent.self) else { return (0, cards) }
        var primaryCount = 0
        var secundaryCount = 0
        var wrongCards = Set<Card>()
        for card in cards {
            if let cardInfoComponent = card.component(ofType: CardInfoComponent.self) {
                let cardIdentifier = cardInfoComponent.identifier
                if legendComponent.primary.contains(cardIdentifier) {
                    primaryCount += 1
                } else if legendComponent.secondary.contains(cardIdentifier) {
                    secundaryCount += 1
                } else {
                    wrongCards.insert(card)
                }
            }
        }
        let pontuation = 4*primaryCount + secundaryCount
        return (pontuation, wrongCards)
    }

    func executeActionFrom(submition: SubmitionResult, wrongCards: Set<Card> = Set<Card>()) {
        switch submition {
        case .gold, .silver, .bronze:
            self.gamePlayManager.nextLevel()
        case .wrong:
            self.gamePlayManager.takeDamage()
            clear(wrongCards: wrongCards)
        }
    }

    func revealCard() {
        var cardRevealedIdentifier: Int?
        cardRevealedIdentifier = getFirstSecondaryIdentifierOutOfBoard()
        if let identifier = cardRevealedIdentifier {
            removeCardsOfDeck(identifier: identifier)
            let card = Card(identifier: identifier, assetName: "hand-card")
            add(card)
        }
    }

    func getFirstSecondaryIdentifierOutOfBoard() -> Int? {
        guard let legendComponent = legend.component(ofType: LegendComponent.self) else { return nil }
        let allSecondaryCardsIdentifiers = legendComponent.primary
        let allIdentifiersOnBoard = getAllCardsIdentifiersOnBoard()
        for secondaryCardIdentifier in allSecondaryCardsIdentifiers {
            if !allIdentifiersOnBoard.contains(secondaryCardIdentifier) {
                return secondaryCardIdentifier
            }
        }
        return nil
    }

    func getAllCardsIdentifiersOnBoard() -> [Int] {
        let identifiers: [Int] = self.cards.compactMap { card in
            guard let cardInfo = card.component(ofType: CardInfoComponent.self) else { return nil }
            return cardInfo.identifier
        }
        return identifiers
    }

    func removeCardsOfDeck(identifier: Int) {
        self.deck.removeAll { card in
            if let cardInfoComponent = card.component(ofType: CardInfoComponent.self) {
                let cardIdentifier = cardInfoComponent.identifier
                return cardIdentifier == identifier
            }
            return false
        }
    }

    func getCardsIdentifiers() -> [Int] {
        return cards.compactMap({
            guard let cardInfo = $0.component(ofType: CardInfoComponent.self) else {return nil}
            return cardInfo.identifier
        })
    }

    func addCorrectCardOfDeckOnBoard() -> Card? {
        var chosenCard: Card?
        guard let legendComponent = legend.component(ofType: LegendComponent.self) else { return nil }
        for card in deck {
            guard let cardInfo = card.component(ofType: CardInfoComponent.self) else { continue }
            if legendComponent.primary.contains(cardInfo.identifier)
                && !getCardsIdentifiers().contains(cardInfo.identifier) {
                chosenCard = card
                removeCardsOfDeck(identifier: cardInfo.identifier)
                break
            }
        }
        guard let cCard = chosenCard else { return nil }
        add(cCard)
        return cCard
    }
}
