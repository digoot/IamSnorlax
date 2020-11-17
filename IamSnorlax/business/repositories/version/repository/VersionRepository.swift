//
//  VersionRepository.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Alamofire
import Foundation
import RxSwift

final class VersionRepository {
    func fetchVersion(id: String) -> PublishSubject<Version?> {
        return VersionResource(id: id).result
    }
}

final class VersionResource: Resource<Version> {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchVersion(id: id)
    }
    
    override func convertToObject(with response: AFDataResponse<Any>) -> Version? {
        return VersionAssembler.assemble(data: response.data)
    }
}
