//
//  GroupApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import Foundation
import ObjectMapper

final class GroupApiObject: ObjectMapperManager<GroupApiObject>, Mappable {
    fileprivate enum Values: String {
        case id, name, pokedexes, versions
    }

    internal var id: Int64?
    internal var name: String?
    internal var pokedexes: [DataSetApiObject]?
    internal var versions: [DataSetApiObject]?

    override func mapping(map: Map) {
        id <- map[Values.id.rawValue]
        name <- map[Values.name.rawValue]
        pokedexes <- map[Values.pokedexes.rawValue]
        versions <- map[Values.versions.rawValue]
    }
}
