//
//  PokemonNameDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 27/10/2020.
//

import Foundation
import RealmSwift

final class PokemonNameDao: DaoManager<PokemonName> {
    func fetchNamesByPokemon(ids: [Int64], locale: String) -> [PokemonName]? {
        let predicate = NSPredicate(format: "pokemon.id IN %@ AND locale == %@", ids, locale)
        return read(predicate, sortBy: "pokemon.id", ascending: true)
    }
}

extension PokemonNameDao {
    func unmanaged() -> PokemonName? {
        return PokemonName(value: self)
    }
}

extension Array where Element == PokemonName {
    func unmanaged() -> [PokemonName]? {
        return self.compactMap{ PokemonName(value: $0) }
    }
}

extension List where Element == PokemonName {
    func replace(with objects: [PokemonName]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
