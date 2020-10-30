//
//  GenerationResultApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

class GenerationResultApiObject: ObjectMapperManager<GenerationResultApiObject>, Mappable {
    fileprivate enum Values: String {
        case name, url
    }

    internal var name: String?
    internal var url: String?

    override func mapping(map: Map) {
        name <- map[Values.name.rawValue]
        url <- map[Values.url.rawValue]
    }
}
