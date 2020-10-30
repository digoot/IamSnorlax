//
//  Pokedex.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

final class Pokedex: Object {
    @objc dynamic var id: Int64 = 0
    var names = List<PokedexName>()
    var descriptions = List<PokedexDescription>()
    var pokemons = List<Pokemon>()
    let groups = LinkingObjects(fromType: Group.self, property: "pokedexes")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int64) {
        self.init()
        self.id = id
    }
}
