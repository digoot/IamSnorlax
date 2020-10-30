//
//  Pokemon.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class Pokemon: Object {
    @objc dynamic var id: Int64 = 0
    var names = List<PokemonName>()
    var descriptions = List<PokemonDescription>()
    var stats = List<PokemonStat>()
    @objc dynamic var height = 0
    @objc dynamic var weight = 0
    @objc dynamic var baseExperience = 0
    @objc dynamic var baby = false
    @objc dynamic var legendary = false
    @objc dynamic var mythical = false
    @objc dynamic var sprite: String? = nil
    @objc dynamic var image: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int64) {
        self.init()
        self.id = id
    }
}
