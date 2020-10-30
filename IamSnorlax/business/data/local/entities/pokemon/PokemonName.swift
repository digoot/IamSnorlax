//
//  PokemonName.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 27/10/2020.
//

import Foundation
import RealmSwift

final class PokemonName: Object {
    @objc dynamic var id = ""
    @objc dynamic var languageId: Int64 = 0
    @objc dynamic var pokemon: Pokemon? = nil
    @objc dynamic var locale: String? = nil
    @objc dynamic var value: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, languageId: Int64) {
        self.init()
        self.id = id
        self.languageId = languageId
    }
}
