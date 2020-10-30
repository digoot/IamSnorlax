//
//  PokedexApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

final class PokedexApiObject: ObjectMapperManager<PokedexApiObject>, Mappable {
    fileprivate enum Values: String {
        case id, names, version_groups, descriptions, pokemon_entries
    }

    internal var id: Int64?
    internal var names: [NamesApiObject]?
    internal var versionGroups: [DataSetApiObject]?
    internal var descriptions: [NamesApiObject]?
    internal var pokemonEntries: [PokemonEntryApiObject]?

    override func mapping(map: Map) {
        id <- map[Values.id.rawValue]
        names <- map[Values.names.rawValue]
        versionGroups <- map[Values.version_groups.rawValue]
        descriptions <- map[Values.descriptions.rawValue]
        pokemonEntries <- map[Values.pokemon_entries.rawValue]
    }
}
