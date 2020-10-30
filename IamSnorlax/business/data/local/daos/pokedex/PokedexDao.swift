//
//  PokedexDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class PokedexDao: DaoManager<Pokedex> {}

extension Pokedex {
    func unmanaged() -> Pokedex? {
        return Pokedex(value: self)
    }
}

extension Array where Element == Pokedex {
    func unmanaged() -> [Pokedex]? {
        return self.compactMap{ Pokedex(value: $0) }
    }
}

extension List where Element == Pokedex {
    func replace(with objects: [Pokedex]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
