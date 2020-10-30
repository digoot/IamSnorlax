//
//  Api.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 12/05/2020.
//

import Alamofire
import Foundation

final class Api: ApiRestManager {
    // MARK: - Variables

    fileprivate let constants = BusinessConstants.shared

    // MARK: - Constructors

    init() {
        super.init(url: constants.apiURL)
    }

    // MARK: - API functions

    func fetchGenerations() -> DataRequest? {
        let service = Endpoint.generations.build()
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchGeneration(id: Int64) -> DataRequest? {
        let service = Endpoint.generations.build(String(id))
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchGeneration(name: String) -> DataRequest? {
        let service = Endpoint.generations.build(name)
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchGroups() -> DataRequest? {
        let service = Endpoint.versionGroup.build()
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchGroup(id: Int64) -> DataRequest? {
        let service = Endpoint.versionGroup.build(String(id))
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchGroup(name: String) -> DataRequest? {
        let service = Endpoint.versionGroup.build(name)
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchVersions() -> DataRequest? {
        let service = Endpoint.version.build()
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchVersion(id: Int64) -> DataRequest? {
        let service = Endpoint.version.build(String(id))
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchVersion(name: String) -> DataRequest? {
        let service = Endpoint.version.build(name)
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchPokedexes() -> DataRequest? {
        let service = Endpoint.pokedex.build()
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchPokedex(id: Int64) -> DataRequest? {
        let service = Endpoint.pokedex.build(String(id))
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchPokedex(name: String) -> DataRequest? {
        let service = Endpoint.pokedex.build(name)
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchPokemons() -> DataRequest? {
        let service = Endpoint.pokemon.build()
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchPokemon(id: Int64) -> DataRequest? {
        let service = Endpoint.pokemon.build(String(id))
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchPokemon(name: String) -> DataRequest? {
        let service = Endpoint.pokemon.build(name)
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
}
