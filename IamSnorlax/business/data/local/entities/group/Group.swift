//
//  Group.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class Group: Object {
    @objc dynamic var id: Int64 = 0
    @objc dynamic var name: String? = nil
    var pokedexes = List<Pokedex>()
    var versions = List<Version>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int64) {
        self.init()
        self.id = id
    }
}
