//
//  SpecialSpriteApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

final class SpecialSpriteApiObject: ObjectMapperManager<SpecialSpriteApiObject>, Mappable {
    fileprivate enum Values: String {
        case front_default, front_female
    }

    internal var frontDefault: String?
    internal var frontFemale: String?
    
    override func mapping(map: Map) {
        frontDefault <- map[Values.front_default.rawValue]
        frontFemale <- map[Values.front_female.rawValue]
    }
}
