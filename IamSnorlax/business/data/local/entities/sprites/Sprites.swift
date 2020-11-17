//
//  Sprites.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 15/11/2020.
//

import Foundation

struct Sprites: Codable {
    var frontDefault: URL?
    var other: OtherSprite?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct OtherSprite: Codable {
    var dreamWorld: DreamWorld?
    var artWork: ArtWork?
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case artWork = "official-artwork"
    }
}

struct DreamWorld: Codable {
    var frontDefault: URL?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct ArtWork: Codable {
    var frontDefault: URL?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
