//
//  Pokemon.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation

struct Pokemon: Codable {
    var id: Int
    var name: String?
    var baseExperience: Int?
    var height: Int?
    var weight: Int?
    var order: Int
    var stats: [PokemonStat]?
    var sprites: Sprites?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case weight
        case order
        case stats
        case sprites
    }
    
}
