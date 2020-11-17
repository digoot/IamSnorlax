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
    func fetchGenerations() -> PublishSubject<[String]?> {
        return GenerationListResource().result
    }
    func fetchGenerationWith(id: String) -> PublishSubject<Generation?> {
        return GenerationResource(id: id).result
    }
}

final class GenerationListResource: Resource<[String]> {
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchGenerations()
    }

    override func convertToObject(with response: AFDataResponse<Any>) -> [String]? {
        return GenerationAssembler.assemble(data: response.data)
    }
}

final class GenerationResource: Resource<Generation> {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchGeneration(id: id)
    }
    
    override func convertToObject(with response: AFDataResponse<Any>) -> Generation? {
        return GenerationAssembler.assemble(data: response.data)
    }
}
