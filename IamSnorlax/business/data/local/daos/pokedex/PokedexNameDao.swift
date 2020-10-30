//
//  PokedexNameDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 27/10/2020.
//

import Foundation
import RealmSwift

final class PokedexNameDao: DaoManager<PokedexName> {}

extension PokedexNameDao {
    func unmanaged() -> PokedexName? {
        return PokedexName(value: self)
    }
}

extension Array where Element == PokedexName {
    func unmanaged() -> [PokedexName]? {
        return self.compactMap{ PokedexName(value: $0) }
    }
}

extension List where Element == PokedexName {
    func replace(with objects: [PokedexName]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
