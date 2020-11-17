//
//  Pokedex.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation

struct Pokedex: Codable {
    var id: Int
    var names: [Name]
    var versionGroups: [DataSet]
    var descriptions: [Description]
    var pokemonEntries: [PokemonEntry]
    
    enum CodingKeys: String, CodingKey {
        case id
        case names
        case versionGroups = "version_groups"
        case descriptions
        case pokemonEntries = "pokemon_entries"
    }
}
