//
//  PokemonDescription.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct PokemonDescription: Codable {
    var text: String?
    var language: DataSet?
    var version: DataSet?
    
    enum CodingKeys: String, CodingKey {
        case text = "flavor_text"
        case language
        case version
    }
}
