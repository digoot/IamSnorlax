//
//  PokemonStat.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 29/10/2020.
//

import Foundation
import RealmSwift

final class PokemonStat: Object {
    @objc dynamic var id = ""
    @objc dynamic var statId: Int64 = 0
    @objc dynamic var name: String? = nil
    @objc dynamic var effort = 0
    @objc dynamic var base = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, statId: Int64) {
        self.init()
        self.id = id
        self.statId = statId
    }
}
