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
    func fetchGroup(id: String) -> PublishSubject<Group?> {
        return GroupResource(id: id).result
    }
}

final class GroupResource: Resource<Group> {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func fetchFromWebService() -> DataRequest? {
        return ApiManager.shared.api.fetchGroup(id: id)
    }
    
    override func convertToObject(with response: AFDataResponse<Any>) -> Group? {
        return GroupAssembler.assemble(data: response.data)
    }
}
