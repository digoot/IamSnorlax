//
//  DataSet.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct DataSet: Codable {
    var name: String
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
