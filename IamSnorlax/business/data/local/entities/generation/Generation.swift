//
//  Generation.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class Generation: Object {
    @objc dynamic var id: Int64 = 0
    var names = List<GenerationName>()
    var groups = List<Group>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int64) {
        self.init()
        self.id = id
    }
}
