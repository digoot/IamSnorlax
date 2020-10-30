//
//  GenerationApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

final class GenerationApiObject: ObjectMapperManager<GenerationApiObject>, Mappable {
    fileprivate enum Values: String {
        case id, names, version_groups
    }

    internal var id: Int64?
    internal var names: [NamesApiObject]?
    internal var versionGroups: [DataSetApiObject]?

    override func mapping(map: Map) {
        id <- map[Values.id.rawValue]
        names <- map[Values.names.rawValue]
        versionGroups <- map[Values.version_groups.rawValue]
    }
}
