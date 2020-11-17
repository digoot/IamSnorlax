//
//  Version.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation

struct Version: Codable {
    var id: Int
    var names: [Name]
    var group: DataSet
    
    enum CodingKeys: String, CodingKey {
        case id
        case names
        case group = "version_group"
    }
}
