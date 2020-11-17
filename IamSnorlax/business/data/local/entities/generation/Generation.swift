//
//  Generation.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation

struct Generation: Codable {
    var id: Int
    var names: [Name]?
    var versionGroups: [DataSet]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case names
        case versionGroups = "version_groups"
    }
}
