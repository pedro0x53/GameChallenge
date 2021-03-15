//
//  RepositoryProtocol.swift
//  GameChallenge
//
//  Created by Gustavo Lemos on 15/03/21.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype D
    associatedtype E
    
    func create(with data: D) -> E?
    func readAll() -> [E]
    func read(identifier: String) -> E?
    func update(_ entity: E, with data: D) -> Bool
    func delete(identifier: String) -> Bool
    func drop() -> Bool
    func saveContext() -> Bool
}
