//
//  PokemonEntryApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 27/10/2020.
//

import Foundation
import ObjectMapper

final class PokemonEntryApiObject: ObjectMapperManager<PokemonEntryApiObject>, Mappable {
    fileprivate enum Values: String {
        case pokemon_species
    }

    internal var pokemon: DataSetApiObject?

    override func mapping(map: Map) {
        pokemon <- map[Values.pokemon_species.rawValue]
    }
}
