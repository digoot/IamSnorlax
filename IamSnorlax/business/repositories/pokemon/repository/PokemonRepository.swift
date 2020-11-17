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
    func fetchPokemonBy(id: String) -> PublishSubject<PokemonSpecie?> {
        return PokemonSpecieResource(id: id).result
    }
    func fetchPokemonDetailsBy(id: String) -> PublishSubject<Pokemon?> {
        return PokemonDetailsResource(id: id).result
    }
}

final class PokemonSpecieResource: Resource<PokemonSpecie> {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchPokemon(id: id)
    }
    
    override func convertToObject(with response: AFDataResponse<Any>) -> PokemonSpecie? {
        return PokemonAssembler.assemble(data: response.data)
    }
}

final class PokemonDetailsResource: Resource<Pokemon> {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchPokemonDetails(id: id)
    }
    
    override func convertToObject(with response: AFDataResponse<Any>) -> Pokemon? {
        return PokemonAssembler.assemble(data: response.data)
    }
}
