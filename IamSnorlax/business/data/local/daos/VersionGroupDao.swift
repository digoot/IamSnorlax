//
//  GroupDao.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

class GroupDao: DaoManager<Group> {
    func read(id: Int64) -> Group? {
        let predicate = NSPredicate(format: "id == %@", id)
        return read(predicate)
    }
}

extension Group {
    func unmanaged() -> Group? {
        return Group(value: self)
    }
}

extension Array where Element == Group {
    func unmanaged() -> [Group]? {
        return self.compactMap{ Group(value: $0) }
    }
}

extension List where Element == Group {
    func replace(with objects: [Group]) {
        self.removeAll()
        self.append(objectsIn: objects)
    }
}
