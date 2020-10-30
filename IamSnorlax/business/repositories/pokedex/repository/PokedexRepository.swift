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
    func fetchPokedexBy(id: Int64) -> ReplaySubject<Pokedex?> {
        return PokedexResource(id: id).result
    }
}

final class PokedexResource: Resource<Pokedex> {
    let pokedexDao: PokedexDao
    let id: Int64
    
    init(id: Int64) {
        pokedexDao = PokedexDao()
        self.id = id
        super.init()
    }
    
    override func fetchFromDataBase() -> Pokedex? {
        return pokedexDao.read(id)
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchPokedex(id: id)
    }
    
    override func saveWebServiceResult(with data: AFDataResponse<Any>) {
        if let result: PokedexApiObject = PokedexApiObject.deserialize(dataResponse: data) {
            PokedexAssembler.assemble(result, dao: pokedexDao)
        }
    }
}
