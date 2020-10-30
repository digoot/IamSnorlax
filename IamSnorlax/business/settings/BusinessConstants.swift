//
//  BusinessConstants.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 21/10/2020.
//

import Alamofire
import Foundation

enum Endpoint: String {
    case generations = "/generation/%@"
    case version = "/version/%@"
    case versionGroup = "/version-group/%@"
    case pokedex = "/pokedex/%@"
    case pokemonSpecies = "/pokemon-species/%@"
    case pokemon = "/pokemon/%@"
}

extension Endpoint {
    func build(_ args: String...) -> String {
        return rawValue.replaceTokenBy(BusinessConstants.token, args)
    }
}

class BusinessConstants {
    static let shared = BusinessConstants()
    static let token = "%@"

    // MARK: - Api configuration

    let apiURL: String = {
        (Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String) ?? ""
    }()
    let spritesEndpoint: String = {
        let imagesURL = (Bundle.main.object(forInfoDictionaryKey: "IMAGES_URL") as? String) ?? ""
        return "\(imagesURL)/sprites/pokemon/"
    }()
    let artworkEndpoint: String = {
        let imagesURL = (Bundle.main.object(forInfoDictionaryKey: "IMAGES_URL") as? String) ?? ""
        return "\(imagesURL)/sprites/pokemon/other/official-artwork/"
    }()

    let timeoutForRequest: TimeInterval = 5
    let timeoutForResource: TimeInterval = 5

    private init() {}
}
