//
//  Version.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class Version: Object {
    @objc dynamic var id: Int64 = 0
    var names = List<VersionName>()
    @objc dynamic var group: Group? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int64) {
        self.init()
        self.id = id
    }
}
