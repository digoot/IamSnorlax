//
//  PokemonSpecie.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct PokemonSpecie: Codable {
    var id: Int
    var names: [Name]
    var descriptions: [PokemonDescription]
    var baby: Bool?
    var legendary: Bool?
    var mythical: Bool?
    var order: Int
    var sprite: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case names
        case descriptions = "flavor_text_entries"
        case baby = "is_baby"
        case legendary = "is_legendary"
        case mythical = "is_mythical"
        case order
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.names = try container.decode([Name].self, forKey: .names)
        self.descriptions = try container.decode([PokemonDescription].self, forKey: .descriptions)
        self.baby = try container.decode(Bool.self, forKey: .baby )
        self.legendary = try container.decode(Bool.self, forKey: .legendary )
        self.mythical = try container.decode(Bool.self, forKey: .mythical )
        self.order = try container.decode(Int.self, forKey: .order )
        self.sprite = URL(string: BusinessConstants.shared.spritesEndpoint + "\(id).png")
    }
}
