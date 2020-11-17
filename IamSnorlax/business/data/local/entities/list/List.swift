//
//  List.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct List: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [DataSet]?
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}
