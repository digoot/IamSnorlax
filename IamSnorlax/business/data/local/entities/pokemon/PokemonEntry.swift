//
//  PokemonEntry.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct PokemonEntry: Codable {
    var entryNumber: Int
    var pokemonSpecies: DataSet
    
    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}
