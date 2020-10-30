//
//  PokemonDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class PokemonDao: DaoManager<Pokemon> {
    func findPokemonsBy(ids: [Int64]?) -> [Pokemon]? {
        guard let ids = ids else { return nil }
        let predicate = NSPredicate(format: "id IN %@", ids)
        return read(predicate)
    }
}

extension Pokemon {
    func unmanaged() -> Pokemon? {
        return Pokemon(value: self)
    }
}

extension Array where Element == Pokemon {
    func unmanaged() -> [Pokemon]? {
        return self.compactMap{ Pokemon(value: $0) }
    }
}

extension List where Element == Pokemon {
    func replace(with objects: [Pokemon]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
