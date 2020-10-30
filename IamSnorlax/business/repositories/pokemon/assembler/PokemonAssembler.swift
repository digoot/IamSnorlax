//
//  PokemonAssembler.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Foundation

final class PokemonAssembler {
    static func assemble(
        pokemonEntries: [PokemonEntryApiObject]?
    ) -> [Pokemon]? {
        guard let pokemonEntries = pokemonEntries else { return nil }
        return pokemonEntries.compactMap { entry in
            guard
                let urlString = entry.pokemon?.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let pokemon = Pokemon(id: id)
            return pokemon
        }
    }
    
    static func assemble(
        _ apiObject: PokemonSpecieApiObject,
        dao: PokemonDao
    ) {
        let pokemonDb = getPokemonFromDb(dao: dao, id: apiObject.id)
        let pokemon = assemblePokemon(apiObject: apiObject, pokemonDb: pokemonDb)
        if let names = assembleNames(apiObject: apiObject, pokemon: pokemon) {
            pokemon?.names.replace(with: names)
        }
        if let pokemonDescription = apiObject.descriptions,
           let locale = UIConstants.shared.locale {
            pokemon?.wording = pokemonDescription
                .filter({ $0.language?.name == locale }).first?.text
        }
        if let baby = apiObject.baby {
            pokemon?.baby = baby
        }
        if let legendary = apiObject.legendary {
            pokemon?.legendary = legendary
        }
        if let mythical = apiObject.mythical {
            pokemon?.mythical = mythical
        }
        if let order = apiObject.order {
            pokemon?.order = order
        }
        if let id = apiObject.id {
            pokemon?.sprite = BusinessConstants.shared.spritesEndpoint + "\(id).png"
            pokemon?.image = BusinessConstants.shared.artworkEndpoint + "\(id).png"
        }
        if let pokemon = pokemon, dao.create(pokemon) {
            Log.print.debug("Updated Pokemon \(pokemon.id)")
        }
    }
    
    static func assemble(
        _ apiObject: PokemonApiObject,
        dao: PokemonDao
    ) {
        let pokemonDb = getPokemonFromDb(dao: dao, id: apiObject.id)?.unmanaged()
        if let height = apiObject.height {
            pokemonDb?.height = height
        }
        if let weight = apiObject.weight {
            pokemonDb?.weight = weight
        }
        if let baseExperience = apiObject.baseExperience {
            pokemonDb?.baseExperience = baseExperience
        }
        if let pokemon = pokemonDb, dao.create(pokemon) {
            Log.print.debug("Updated Pokemon \(pokemon.id)")
        }
    }
    
    static fileprivate func assemblePokemon(
        apiObject: PokemonSpecieApiObject,
        pokemonDb: Pokemon?
    ) -> Pokemon? {
        guard
            let id = apiObject.id
        else { return nil }
        if let pokemon = pokemonDb {
            return pokemon
        } else {
            let pokemon = Pokemon(id: id)
            return pokemon
        }
    }
    
    static fileprivate func assembleNames(
        apiObject: PokemonSpecieApiObject,
        pokemon: Pokemon?
    ) -> [PokemonName]? {
        guard let names = apiObject.names else { return nil }
        return names.compactMap{ nameApiObject in
            guard
                let versionId = apiObject.id,
                let urlString = nameApiObject.language?.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let name = PokemonName(id: "\(id)-\(versionId)", languageId: id)
            name.pokemon = pokemon
            name.locale = nameApiObject.language?.name
            name.value = nameApiObject.name
            return name
        }
    }

    // MARK: - Database fetches

    static fileprivate func getPokemonFromDb(dao: PokemonDao?, id: Int64?) -> Pokemon? {
        return dao?.read(id)?.unmanaged()
    }
}
