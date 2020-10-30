//
//  OtherSpritesApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

final class OtherSpritesApiObject: ObjectMapperManager<OtherSpritesApiObject>, Mappable {
    fileprivate enum Values: String {
        case dream_world
    }

    internal var dreamWorld: SpecialSpriteApiObject?
    internal var officialArtwork: SpecialSpriteApiObject?
    
    override func mapping(map: Map) {
        dreamWorld <- map[Values.dream_world.rawValue]
        officialArtwork <- map["official-artwork"]
    }
}
