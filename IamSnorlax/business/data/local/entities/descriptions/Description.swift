//
//  Description.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct Description: Codable {
    var description: String?
    var language: DataSet?
    
    enum CodingKeys: String, CodingKey {
        case description
        case language
    }
}
