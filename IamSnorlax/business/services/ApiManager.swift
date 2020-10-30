//
//  ApiManager.swift
//  Dogoplay
//
//  Created by Diego Otero Mata on 12/05/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import Foundation

final class ApiManager {
    // MARK: - Variables

    var stories: ApiStories
    var auth: ApiAuth
    var games: ApiGames

    static let shared = ApiManager()

    // MARK: - Constructor

    private init() {
        stories = ApiStories()
        auth = ApiAuth()
        games = ApiGames()
    }
}
