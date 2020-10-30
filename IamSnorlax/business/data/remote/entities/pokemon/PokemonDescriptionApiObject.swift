//
//  PokemonDescriptionApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 29/10/2020.
//

import Foundation
import ObjectMapper

final class PokemonDescriptionApiObject: ObjectMapperManager<PokemonDescriptionApiObject>, Mappable {
    fileprivate enum Values: String {
        case flavor_text, language, version
    }

    internal var text: String?
    internal var language: DataSetApiObject?
    internal var version: DataSetApiObject?

    override func mapping(map: Map) {
        text <- map[Values.flavor_text.rawValue]
        language <- map[Values.language.rawValue]
        version <- map[Values.version.rawValue]
    }
}
