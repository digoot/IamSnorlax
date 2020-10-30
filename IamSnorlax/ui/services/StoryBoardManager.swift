//
//  StoryBoardManager.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import UIKit

class StoryboardManager {
    // MARK: - Variables
    static let shared = StoryboardManager()
    
    let generationList: UIStoryboard
    let versionList: UIStoryboard
    let pokemonList: UIStoryboard
    let pokemonDetails: UIStoryboard
    
    // MARK: - Constructor
    private init() {
        generationList = UIStoryboard(name: "GenerationList", bundle: nil)
        versionList = UIStoryboard(name: "VersionList", bundle: nil)
        pokemonList = UIStoryboard(name: "PokemonList", bundle: nil)
        pokemonDetails = UIStoryboard(name: "PokemonDetails", bundle: nil)
    }
    
}
