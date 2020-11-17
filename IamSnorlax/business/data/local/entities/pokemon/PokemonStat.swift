//
//  PokemonStat.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 29/10/2020.
//

import Foundation

struct PokemonStat: Codable {
    var baseStat: Int?
    var effort: Int?
    var stat: DataSet?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}
