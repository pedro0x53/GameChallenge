//
//  LegendRepository.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 15/03/21.
//

import Foundation

class LegendRepository: RepositoryProtocol {
    typealias Data = LegendData
    typealias Entity = LegendModel

    func create(with data: LegendData) -> LegendModel? {
        return nil
    }

    func readAll() -> [LegendModel] {
        return []
    }

    func read(identifier: String) -> LegendModel? {
        return nil
    }

    func update(_ entity: LegendModel, with data: LegendData) -> Bool {
        return false
    }

    func delete(identifier: String) -> Bool {
        return false
    }

    func drop() -> Bool {
        return false
    }

    func saveContext() -> Bool {
        return false
    }

}
