//
//  GenerationNameDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class GenerationNameDao: DaoManager<GenerationName> {}

extension GenerationName {
    func unmanaged() -> GenerationName? {
        return GenerationName(value: self)
    }
}

extension Array where Element == GenerationName {
    func unmanaged() -> [GenerationName]? {
        return self.compactMap{ GenerationName(value: $0) }
    }
}

extension List where Element == GenerationName {
    func replace(with objects: [GenerationName]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
