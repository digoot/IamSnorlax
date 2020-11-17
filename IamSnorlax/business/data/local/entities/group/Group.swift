//
//  Group.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation

struct Group: Codable {
    var id: Int
    var name: String
    var pokedexes: [DataSet]
    var versions: [DataSet]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pokedexes
        case versions
    }
}
