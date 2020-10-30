//
//  PokemonApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

final class PokemonApiObject: ObjectMapperManager<PokemonApiObject>, Mappable {
    fileprivate enum Values: String {
        case id, name, base_experience, height, is_default, order, sprites, stats, weight
    }

    internal var id: Int64?
    internal var name: String?
    internal var baseExperience: Int?
    internal var height: Int?
    internal var eligible: Bool?
    internal var weight: Int?
    internal var order: Int?
    internal var stats: [PokemonStatApiObject]?
    internal var sprites: [SpritesApiObject]?

    override func mapping(map: Map) {
        id <- map[Values.id.rawValue]
        name <- map[Values.name.rawValue]
        baseExperience <- map[Values.base_experience.rawValue]
        height <- map[Values.height.rawValue]
        weight <- map[Values.weight.rawValue]
        order <- map[Values.order.rawValue]
        stats <- map[Values.stats.rawValue]
        sprites <- map[Values.sprites.rawValue]
    }
}
