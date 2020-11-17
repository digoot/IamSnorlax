//
//  PokedexRepository.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Alamofire
import Foundation
import RxSwift

final class PokedexRepository {
    func fetchPokedexBy(id: String) -> PublishSubject<Pokedex?> {
        return PokedexResource(id: id).result
    }
}

final class PokedexResource: Resource<Pokedex> {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchPokedex(id: id)
    }
    
    override func convertToObject(with response: AFDataResponse<Any>) -> Pokedex? {
        return PokedexAssembler.assemble(data: response.data)
    }
}
