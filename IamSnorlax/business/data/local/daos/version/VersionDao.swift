//
//  VersionDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class VersionDao: DaoManager<Version> {}

extension Version {
    func unmanaged() -> Version? {
        return Version(value: self)
    }
}

extension Array where Element == Version {
    func unmanaged() -> [Version]? {
        return self.compactMap{ Version(value: $0) }
    }
}

extension List where Element == Version {
    func replace(with objects: [Version]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
