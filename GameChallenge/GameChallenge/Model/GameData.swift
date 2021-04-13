//
//  GameData.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 09/04/21.
//

import Foundation

class GameData {
    public static let deck: [[String: Any]] = [
        ["identifier": 1, "assetName": "albino"],
        ["identifier": 2, "assetName": "cachimbo"],
        ["identifier": 3, "assetName": "cobra"],
        ["identifier": 4, "assetName": "floresta"],
        ["identifier": 5, "assetName": "folhas"],
        ["identifier": 6, "assetName": "garrafa"],
        ["identifier": 7, "assetName": "olho"],
        ["identifier": 8, "assetName": "peludo"],
        ["identifier": 9, "assetName": "bocarra"],
        ["identifier": 10, "assetName": "chifres"],
        ["identifier": 11, "assetName": "flamejante"],
        ["identifier": 12, "assetName": "fogo"],
        ["identifier": 13, "assetName": "folivora"],
        ["identifier": 14, "assetName": "gorro"],
        ["identifier": 15, "assetName": "olhos"],
        ["identifier": 16, "assetName": "redemoinho"]
    ]

    public static let legends: [[String: Any]] = [
        [
            "identifier": 0,
            "assetName": "",
            "primarySolution": [6, 2, 14, 16],
            "secondarySolution": [],
            "hints": [
                "Teste 1",
                "Teste 2"
            ]
        ]
    ]
}
