//
//  PokemonStatApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 29/10/2020.
//

import Foundation
import ObjectMapper

final class PokemonStatApiObject: ObjectMapperManager<PokemonStatApiObject>, Mappable {
    fileprivate enum Values: String {
        case base_stat, effort, stat
    }

    internal var baseStat: Int?
    internal var effort: Int?
    internal var stat: [DataSetApiObject]?

    override func mapping(map: Map) {
        baseStat <- map[Values.base_stat.rawValue]
        effort <- map[Values.effort.rawValue]
        stat <- map[Values.stat.rawValue]
    }
}
