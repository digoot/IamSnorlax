//
//  GroupRepository.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Alamofire
import Foundation
import RxSwift

final class GroupRepository {
    func fetchGroup(id: Int64) -> ReplaySubject<Group?> {
        return GroupResource(id: id).result
    }
}

final class GroupResource: Resource<Group> {
    let groupDao: GroupDao
    let id: Int64
    
    init(id: Int64) {
        groupDao = GroupDao()
        self.id = id
        super.init()
    }
    
    override func fetchFromDataBase() -> Group? {
        return groupDao.read(id)
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchGroup(id: id)
    }
    
    override func saveWebServiceResult(with data: AFDataResponse<Any>) {
        if let result: GroupApiObject = GroupApiObject.deserialize(dataResponse: data) {
            GroupAssembler.assemble(result, dao: groupDao)
        }
    }
}
