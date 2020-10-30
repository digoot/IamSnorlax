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
    func fetchVersion(id: Int64) -> ReplaySubject<Version?> {
        return VersionResource(id: id).result
    }
}

final class VersionResource: Resource<Version> {
    let versionDao: VersionDao
    let id: Int64
    
    init(id: Int64) {
        versionDao = VersionDao()
        self.id = id
        super.init()
    }
    
    override func fetchFromDataBase() -> Version? {
        return versionDao.read(id)
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchVersion(id: id)
    }
    
    override func saveWebServiceResult(with data: AFDataResponse<Any>) {
        if let result: VersionApiObject = VersionApiObject.deserialize(dataResponse: data) {
            VersionAssembler.assemble(result, dao: versionDao)
        }
    }
}
