//
//  ListApiObject.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import ObjectMapper

final class ListApiObject: ObjectMapperManager<ListApiObject>, Mappable {
    fileprivate enum Values: String {
        case count, next, previous, results
    }

    internal var count: Int?
    internal var next: String?
    internal var previous: String?
    internal var results: [DataSetApiObject]?

    override func mapping(map: Map) {
        count <- map[Values.count.rawValue]
        next <- map[Values.next.rawValue]
        previous <- map[Values.previous.rawValue]
        results <- map[Values.results.rawValue]
    }
}
