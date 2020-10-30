//
//  PokedexDescriptionDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class PokedexDescriptionDao: DaoManager<PokedexDescription> {}

extension PokedexDescription {
    func unmanaged() -> PokedexDescription? {
        return PokedexDescription(value: self)
    }
}

extension Array where Element == PokedexDescription {
    func unmanaged() -> [PokedexDescription]? {
        return self.compactMap{ PokedexDescription(value: $0) }
    }
}

extension List where Element == PokedexDescription {
    func replace(with objects: [PokedexDescription]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
