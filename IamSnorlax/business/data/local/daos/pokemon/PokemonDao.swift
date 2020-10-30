//
//  PokemonDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class PokemonDao: DaoManager<Pokemon> {
    func read(id: Int64) -> Pokemon? {
        let predicate = NSPredicate(format: "id == %@", id)
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
