//
//  Api.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 12/05/2020.
//

import Alamofire
import Foundation

final class Api: ApiRestManager {
    // MARK: - Variables

    fileprivate let constants = BusinessConstants.shared

    // MARK: - Constructors

    init() {
        let endpoint = constants.infoApiEndpoint
        super.init(endpoint: endpoint)
    }

    // MARK: - API functions

    func fetchGenerations(id: Int? = nil) -> DataRequest? {
        guard let id = id else {
            let service = Service.generations.build()
            return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
        }
        let service = Service.generations.build(String(id))
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
    
    func fetchGenerations(name: String? = nil) -> DataRequest? {
        guard let name = name else {
            let service = Service.generations.build()
            return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
        }
        let service = Service.generations.build(name)
        return get(service: service, parameters: nil, headers: nil, requestModifier: nil)
    }
}
