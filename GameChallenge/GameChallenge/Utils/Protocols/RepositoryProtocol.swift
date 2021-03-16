//
//  RepositoryProtocol.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 15/03/21.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype Data
    associatedtype Entity

    func create(with data: Data) -> Entity?
    func readAll() -> [Entity]
    func read(identifier: String) -> Entity?
    func update(_ entity: Entity, with data: Data) -> Bool
    func delete(identifier: String) -> Bool
    func drop() -> Bool
    func saveContext() -> Bool
}
