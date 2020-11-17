//
//  Name.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct Name: Codable {
    var language: DataSet?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case language
        case name
    }
}
