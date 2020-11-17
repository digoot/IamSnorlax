//
//  PokemonDetailsProtocols.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 28/10/2020.
//

import RxSwift
import UIKit

// MARK: Protocols for presenter

protocol PresenterToViewPokemonDetailsProtocol: class {
    var presenter: ViewToPresenterPokemonDetailsProtocol? { get set }
}

protocol PresenterToInteractorPokemonDetailsProtocol: class {
    func fetchPokemonDetailsBy(id: String) -> PublishSubject<Pokemon?>
}

protocol PresenterToRouterPokemonDetailsProtocol: class {}

// MARK: Protocols for View

protocol ViewToPresenterPokemonDetailsProtocol: class {
    var router: PresenterToRouterPokemonDetailsProtocol? { get set }
    var interactor: PresenterToInteractorPokemonDetailsProtocol? { get set }
    var view: PresenterToViewPokemonDetailsProtocol? { get set }
    var pokemon: PokemonSpecie? { get set }
    var fetchedInfo: PublishSubject<Pokemon?> { get set }
    func viewIsReady()
}
