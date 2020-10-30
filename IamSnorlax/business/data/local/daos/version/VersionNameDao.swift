//
//  VersionNameNameDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class VersionNameNameDao: DaoManager<VersionName> {}

extension VersionName {
    func unmanaged() -> VersionName? {
        return VersionName(value: self)
    }
}

extension Array where Element == VersionName {
    func unmanaged() -> [VersionName]? {
        return self.compactMap{ VersionName(value: $0) }
    }
}

extension List where Element == VersionName {
    func replace(with objects: [VersionName]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
