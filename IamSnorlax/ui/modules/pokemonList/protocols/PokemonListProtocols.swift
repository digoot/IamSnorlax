//
//  PokemonListProtocols.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import RxSwift
import UIKit

// MARK: Protocols for presenter

protocol PresenterToViewPokemonListProtocol: class {
    var presenter: ViewToPresenterPokemonListProtocol? { get set }
}

protocol PresenterToInteractorPokemonListProtocol: class {
    func fetchPokedexBy(id: String) -> PublishSubject<Pokedex?>
    func fetchPokemonBy(id: String) -> PublishSubject<PokemonSpecie?>
}

protocol PresenterToRouterPokemonListProtocol: class {
    func navigateToPokemonDetails(viewController: UIViewController, pokemon: PokemonSpecie)
}

// MARK: Protocols for View

protocol ViewToPresenterPokemonListProtocol: class {
    var router: PresenterToRouterPokemonListProtocol? { get set }
    var interactor: PresenterToInteractorPokemonListProtocol? { get set }
    var view: PresenterToViewPokemonListProtocol? { get set }
    var pokedexSets: [DataSet]? { get set }
    var version: Version? { get set }
    var pokemons: PublishSubject<[PokemonSpecie]?> { get set }
    func viewIsReady()
    func loadPokemons(page: Int)
    func navigateToPokemonDetails(pokemon: PokemonSpecie)
}
