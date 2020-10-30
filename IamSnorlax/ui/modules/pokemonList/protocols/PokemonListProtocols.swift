//
//  PokemonListProtocols.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import UIKit
import RxSwift

// MARK: Protocols for presenter

protocol PresenterToViewPokemonListProtocol: class {
    var presenter : ViewToPresenterPokemonListProtocol? { get set }
}

protocol PresenterToInteractorPokemonListProtocol : class {
    
}

protocol PresenterToRouterPokemonListProtocol : class {
    
}

// MARK: Protocols for View

protocol ViewToPresenterPokemonListProtocol : class {
    var router: PresenterToRouterPokemonListProtocol? { get set }
    var interactor: PresenterToInteractorPokemonListProtocol? { get set }
    var view: PresenterToViewPokemonListProtocol? { get set }
    func viewIsReady()
}
