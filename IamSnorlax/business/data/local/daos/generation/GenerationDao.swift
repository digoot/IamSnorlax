//
//  GenerationDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class GenerationDao: DaoManager<Generation> {}

extension Generation {
    func unmanaged() -> Generation? {
        return Generation(value: self)
    }
}

extension Array where Element == Generation {
    func unmanaged() -> [Generation]? {
        return self.compactMap{ Generation(value: $0) }
    }
}

extension List where Element == Generation {
    func replace(with objects: [Generation]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
