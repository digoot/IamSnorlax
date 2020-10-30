//
//  PokemonDetailsProtocols.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 28/10/2020.
//

import UIKit
import RxSwift

// MARK: Protocols for presenter

protocol PresenterToViewPokemonDetailsProtocol: class {
    var presenter : ViewToPresenterPokemonDetailsProtocol? { get set }
}

protocol PresenterToInteractorPokemonDetailsProtocol : class {
    
}

protocol PresenterToRouterPokemonDetailsProtocol : class {
    
}

// MARK: Protocols for View

protocol ViewToPresenterPokemonDetailsProtocol : class {
    var router: PresenterToRouterPokemonDetailsProtocol? { get set }
    var interactor: PresenterToInteractorPokemonDetailsProtocol? { get set }
    var view: PresenterToViewPokemonDetailsProtocol? { get set }
    func viewIsReady()
}
