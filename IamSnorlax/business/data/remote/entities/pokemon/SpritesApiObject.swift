//
//  SpritesApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

final class SpritesApiObject: ObjectMapperManager<SpritesApiObject>, Mappable {
    fileprivate enum Values: String {
        case back_default, back_female, back_shiny, back_shiny_female, front_default, front_female, front_shiny,
             front_shiny_female, other
    }

    internal var backDefault: String?
    internal var backFemale: String?
    internal var backShiny: String?
    internal var backShinyFemale: String?
    internal var frontDefault: String?
    internal var fromtFemale: String?
    internal var frontShiny: String?
    internal var frontShinyFemale: String?
    internal var other: OtherSpritesApiObject?
    
    override func mapping(map: Map) {
        backDefault <- map[Values.back_default.rawValue]
        backFemale <- map[Values.back_female.rawValue]
        backShiny <- map[Values.back_shiny.rawValue]
        backShinyFemale <- map[Values.back_shiny_female.rawValue]
        frontDefault <- map[Values.front_default.rawValue]
        fromtFemale <- map[Values.front_female.rawValue]
        frontShiny <- map[Values.front_shiny.rawValue]
        frontShinyFemale <- map[Values.front_shiny_female.rawValue]
        other <- map[Values.other.rawValue]
    }
}
