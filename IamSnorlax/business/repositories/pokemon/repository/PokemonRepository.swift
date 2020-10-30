//
//  PokemonRepository.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Alamofire
import Foundation
import RxSwift

final class PokemonRepository {
    func fetchPokemonBy(id: Int64, version: Version?) -> ReplaySubject<Pokemon?> {
        return PokemonSpecieResource(id: id, version: version).result
    }
    func fetchPokemonDetailsBy(id: Int64) -> ReplaySubject<Pokemon?> {
        return PokemonDetailsResource(id: id).result
    }
    func fetchPokemonNamesBy(ids: [Int64], locale: String) -> ReplaySubject<[PokemonName]?> {
        return PokemonNamesResource(ids: ids, locale: locale).result
    }
}

final class PokemonSpecieResource: Resource<Pokemon> {
    let pokemonDao: PokemonDao
    let id: Int64
    let version: Version?
    
    init(id: Int64, version: Version?) {
        pokemonDao = PokemonDao()
        self.id = id
        self.version = version
        super.init()
    }
    
    override func fetchFromDataBase() -> Pokemon? {
        return pokemonDao.read(id)
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchPokemon(id: id)
    }
    
    override func saveWebServiceResult(with data: AFDataResponse<Any>) {
        if let result: PokemonSpecieApiObject = PokemonSpecieApiObject.deserialize(dataResponse: data) {
            PokemonAssembler.assemble(result, dao: pokemonDao)
        }
    }
}

final class PokemonNamesResource: Resource<[PokemonName]> {
    let pokemonNameDao: PokemonNameDao
    let ids: [Int64]
    let locale: String
    
    init(ids: [Int64], locale: String) {
        pokemonNameDao = PokemonNameDao()
        self.ids = ids
        self.locale = locale
        super.init()
    }
    
    override func fetchFrom() -> ReadType {
        return .onlyDataBase
    }
    
    override func fetchFromDataBase() -> [PokemonName]? {
        return pokemonNameDao.fetchNamesByPokemon(ids: ids, locale: locale)
    }
}

final class PokemonDetailsResource: Resource<Pokemon> {
    let pokemonDao: PokemonDao
    let id: Int64
    
    init(id: Int64) {
        pokemonDao = PokemonDao()
        self.id = id
        super.init()
    }
    
    override func fetchFromDataBase() -> Pokemon? {
        return pokemonDao.read(id)
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchPokemonDetails(id: id)
    }
    
    override func saveWebServiceResult(with data: AFDataResponse<Any>) {
        if let result: PokemonApiObject = PokemonApiObject.deserialize(dataResponse: data) {
            PokemonAssembler.assemble(result, dao: pokemonDao)
        }
    }
}
