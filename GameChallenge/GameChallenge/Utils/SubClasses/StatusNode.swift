//
//  StatusNode.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 12/03/21.
//

import SpriteKit

class StatusNode: SKNode {
    private let label = SKLabelNode()
    private let icon: SKSpriteNode

    init(icon: String, label: String, size: CGSize) {
        self.label.text = label
        let texture = SKTexture(imageNamed: icon)
        self.icon = SKSpriteNode(texture: texture, color: .clear, size: size)

        super.init()

        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        label.position.x = -scene!.size.width / 2  + 30
        label.position.y = scene!.size.height / 2 - 30
        self.addChild(label)
        self.addChild(icon)
       
        //Fazer o ajuste aqui da label e icon pra colocar os 2 na pos. correta
        
        
    }

    func setLabelText(to text: String) {
        self.label.text = text
    }
}
