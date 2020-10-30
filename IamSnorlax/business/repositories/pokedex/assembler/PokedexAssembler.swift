//
//  PokedexAssembler.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Foundation

final class PokedexAssembler {
    static func assemble(
        dataSets: [DataSetApiObject]?
    ) -> [Pokedex]? {
        guard let dataSets = dataSets else { return nil }
        return dataSets.compactMap { set in
            guard
                let urlString = set.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let pokedex = Pokedex(id: id)
            return pokedex
        }
    }
    
    static func assemble(
        _ apiObject: PokedexApiObject,
        dao: PokedexDao
    ) {
        let pokedexDb = getPokedexFromDb(dao: dao, id: apiObject.id)
        let pokedex = assemblePokedex(apiObject: apiObject, pokedexDb: pokedexDb)
        if let names = assembleNames(apiObject: apiObject) {
            pokedex?.names.replace(with: names)
        }
        if let descriptions = assembleDescriptions(apiObject: apiObject) {
            pokedex?.descriptions.replace(with: descriptions)
        }
        if let pokemons = PokemonAssembler.assemble(pokemonEntries: apiObject.pokemonEntries) {
            pokedex?.pokemons.replace(with: pokemons)
        }
        if let pokedex = pokedex, dao.create(pokedex) {
            Log.print.debug("Updated Pokedex \(pokedex.id)")
        }
    }
    
    static fileprivate func assemblePokedex(
        apiObject: PokedexApiObject,
        pokedexDb: Pokedex?
    ) -> Pokedex? {
        guard
            let id = apiObject.id
        else { return nil }
        if let pokedex = pokedexDb {
            return pokedex
        } else {
            let pokedex = Pokedex(id: id)
            return pokedex
        }
    }
    
    static fileprivate func assembleNames(
        apiObject: PokedexApiObject
    ) -> [PokedexName]? {
        guard let names = apiObject.names else { return nil }
        return names.compactMap{ nameApiObject in
            guard
                let versionId = apiObject.id,
                let urlString = nameApiObject.language?.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let name = PokedexName(id: "\(id)-\(versionId)", languageId: id)
            name.locale = nameApiObject.language?.name
            name.value = nameApiObject.name
            return name
        }
    }
    
    static fileprivate func assembleDescriptions(
        apiObject: PokedexApiObject
    ) -> [PokedexDescription]? {
        guard let descriptions = apiObject.descriptions else { return nil }
        return descriptions.compactMap{ descriptionApiObject in
            guard
                let versionId = apiObject.id,
                let urlString = descriptionApiObject.language?.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let name = PokedexDescription(id: "\(id)-\(versionId)", languageId: id)
            name.locale = descriptionApiObject.language?.name
            name.value = descriptionApiObject.name
            return name
        }
    }

    // MARK: - Database fetches

    static fileprivate func getPokedexFromDb(dao: PokedexDao?, id: Int64?) -> Pokedex? {
        return dao?.read(id)?.unmanaged()
    }
}
