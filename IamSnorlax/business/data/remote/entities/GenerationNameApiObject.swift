//
//  NamesApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

class NamesApiObject: ObjectMapperManager<NamesApiObject>, Mappable {
    fileprivate enum Values: String {
        case language, name
    }

    internal var language: DataSetApiObject?
    internal var name: String?

    override func mapping(map: Map) {
        language <- map[Values.language.rawValue]
        name <- map[Values.name.rawValue]
    }
}
