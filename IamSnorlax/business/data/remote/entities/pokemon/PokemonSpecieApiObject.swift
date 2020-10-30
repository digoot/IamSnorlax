//
//  PokemonSpecieApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 27/10/2020.
//

import Foundation
import ObjectMapper

final class PokemonSpecieApiObject: ObjectMapperManager<PokemonSpecieApiObject>, Mappable {
    fileprivate enum Values: String {
        case id, names, flavor_text_entries, is_baby, is_legendary, is_mythical
    }

    internal var id: Int64?
    internal var names: [NamesApiObject]?
    internal var descriptions: [PokemonDescriptionApiObject]?
    internal var baby: Bool?
    internal var legendary: Bool?
    internal var mythical: Bool?

    override func mapping(map: Map) {
        id <- map[Values.id.rawValue]
        names <- map[Values.names.rawValue]
        descriptions <- map[Values.flavor_text_entries.rawValue]
        baby <- map[Values.is_baby.rawValue]
        legendary <- map[Values.is_legendary.rawValue]
        mythical <- map[Values.is_mythical.rawValue]
    }
}
