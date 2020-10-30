//
//  PokemonStatDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 29/10/2020.
//

import Foundation
import RealmSwift

final class PokemonStatDao: DaoManager<PokemonStat> {}

extension PokemonStatDao {
    func unmanaged() -> PokemonStat? {
        return PokemonStat(value: self)
    }
}

extension Array where Element == PokemonStat {
    func unmanaged() -> [PokemonStat]? {
        return self.compactMap{ PokemonStat(value: $0) }
    }
}

extension List where Element == PokemonStat {
    func replace(with objects: [PokemonStat]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
