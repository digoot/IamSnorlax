//
//  ApiManager.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 12/05/2020.
//

import Foundation

final class ApiManager {
    // MARK: - Variables

    var api: Api

    static let shared = ApiManager()

    // MARK: - Constructor

    private init() {
        api = Api()
    }
}
