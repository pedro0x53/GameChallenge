//
//  SpeechManager.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 13/04/21.
//

import SpriteKit
import GameplayKit

enum SpeechType: String {
    case wrong = "Hahahaha..."
    case goodHand = "Hmm, gostei dessa mão."
    case veryGoodHand = "Essa mão está bem \n proxima da vitória."
}

class SpeechManager {
    private let legendID: Int

    private var handDrawsCount: Int = 0

    private var currentHintIndex: Int = 0

    private let gameplayManager: GameplayManager

    private let node = SpeechBubbleNode()

    init(manager: GameplayManager, legendID: Int) {
        self.gameplayManager = manager
        self.legendID = legendID
        setupLayout()
    }

    private func setupLayout() {
        // self.node.position =
        self.node.alpha = 0
        self.gameplayManager.scene.addChild(self.node)
    }

    private func sayHint() {
        if let hints = GameData.legends[self.legendID]["hints"] as? [String],
           !hints.isEmpty {
            if currentHintIndex == hints.count - 1 {
                currentHintIndex = 0
            }

            self.node.setText(hints[currentHintIndex])
            currentHintIndex += 1

            self.node.run(SKAction.sequence([
                SKAction.wait(forDuration: 5),
                SKAction.fadeOut(withDuration: 0.5)
            ]))
        }
    }

    func sayComment(_ type: SpeechType) {
        self.node.setText(type.rawValue)
        self.node.run(SKAction.sequence([
            SKAction.wait(forDuration: 3),
            SKAction.fadeOut(withDuration: 1),
            SKAction.run(shouldSayHint)
        ]))
    }

    private func shouldSayHint() {
        if handDrawsCount == 4 {
            handDrawsCount = 0
            self.sayHint()
        }
    }

    func drawingNewHand() {
        self.handDrawsCount += 1

        let correctCount = self.gameplayManager.handManager.correctCardsInHandCount()
        if correctCount >= 3 {
            self.sayComment(.veryGoodHand)
        } else if correctCount >= 2 {
            self.sayComment(.goodHand)
        }
    }
}
