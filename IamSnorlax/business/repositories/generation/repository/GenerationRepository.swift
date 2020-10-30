//
//  GenerationRepository.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Alamofire
import Foundation
import RxSwift

final class GenerationRepository {
    func fetchGenerations() -> ReplaySubject<[Int64]?> {
        return GenerationListResource().result
    }
    func fetchGenerationWith(id: Int64) -> ReplaySubject<Generation?> {
        return GenerationResource(id: id).result
    }
}

final class GenerationListResource: Resource<[Int64]> {
    override func fetchFrom() -> ReadType {
        return .onlyWebService
    }

    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchGenerations()
    }

    override func convertToObject(with data: AFDataResponse<Any>) -> [Int64]? {
        guard let result: ListApiObject = ListApiObject.deserialize(dataResponse: data) else { return nil }
        return GenerationAssembler.assemble(list: result)
    }
}

final class GenerationResource: Resource<Generation> {
    let generationDao: GenerationDao
    let id: Int64
    
    init(id: Int64) {
        generationDao = GenerationDao()
        self.id = id
        super.init()
    }
    
    override func fetchFromDataBase() -> Generation? {
        return generationDao.read(id)
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchGeneration(id: id)
    }
    
    override func saveWebServiceResult(with data: AFDataResponse<Any>) {
        if let result: GenerationApiObject = GenerationApiObject.deserialize(dataResponse: data) {
            GenerationAssembler.assemble(result, dao: generationDao)
        }
    }
}
