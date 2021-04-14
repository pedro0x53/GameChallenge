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
    case veryGoodHand = "Essa mão tá MUITO boa."
}

class SpeechManager: SpeechBubbleDelegate {
    private let legendID: Int

    private var handDrawsCount: Int = 0 {
        didSet {
            self.shouldSayHint()
        }
    }

    private var currentHintIndex: Int = 0

    private let gameplayManager: GameplayManager

    private let node: SpeechBubbleNode = SpeechBubbleNode()

    private var lines: [String] = []

    private var actionKeys: [String] = []

    init(manager: GameplayManager, legendID: Int) {
        self.gameplayManager = manager
        self.legendID = legendID
        setupLayout()
        node.delegate = self
    }

    private func setupLayout() {
        // self.node.position =
        self.node.alpha = 0
        self.gameplayManager.scene.addChild(self.node)
    }

    func speak() {
        if let currentActionKey = actionKeys.first,
           let currentAction = self.node.action(forKey: currentActionKey),
           currentAction.duration == 0 {
            self.actionKeys.removeFirst()
            self.nextLine()
        } else {
            self.nextLine()
        }
    }

    func nextLine() {
        if let line = self.lines.first {

            self.lines.removeFirst()
            self.node.setText(line)

            self.node.removeAllActions()

            let actionKey = UUID().uuidString
            self.actionKeys.append(actionKey)

            self.node.run(SKAction.sequence([
                SKAction.fadeIn(withDuration: 0.5),
                SKAction.wait(forDuration: 3),
                SKAction.run(self.speak)
            ]), withKey: actionKey)

        } else {
            self.node.removeAllActions()
            self.node.run(SKAction.fadeOut(withDuration: 0.5))
        }
    }

    func sayComment(_ type: SpeechType) {
        self.lines.append(type.rawValue)
        self.speak()
    }

    private func shouldSayHint() {
        if handDrawsCount == 4 {
            handDrawsCount = 0
            if let hint = self.getHint() {
                self.lines.append(hint)
                self.speak()
            }
        }
    }

    private func getHint() -> String? {
        if let hints = GameData.legends[self.legendID]["hints"] as? [String],
           !hints.isEmpty {
            if currentHintIndex == hints.count - 1 {
                currentHintIndex = 0
            }

            let hint = hints[currentHintIndex]
            currentHintIndex += 1

            return hint
        }
        return nil
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
