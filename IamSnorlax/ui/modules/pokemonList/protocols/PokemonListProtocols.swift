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
    func fetchPokedexBy(id: Int64) -> ReplaySubject<Pokedex?>
    func fetchPokemonBy(id: Int64, version: Version?) -> ReplaySubject<Pokemon?>
    func fetchPokemonNamesBy(ids: [Int64], locale: String) -> ReplaySubject<[PokemonName]?>
}

protocol PresenterToRouterPokemonListProtocol: class {
    func navigateToPokemonDetails(viewController: UIViewController, pokemon: Pokemon, version: Version?)
}

// MARK: Protocols for View

protocol ViewToPresenterPokemonListProtocol: class {
    var router: PresenterToRouterPokemonListProtocol? { get set }
    var interactor: PresenterToInteractorPokemonListProtocol? { get set }
    var view: PresenterToViewPokemonListProtocol? { get set }
    var pokedexes: [Pokedex]? { get set }
    var version: Version? { get set }
    var pokemons: ReplaySubject<[Pokemon]?> { get set }
    var pokemonsNames: ReplaySubject<[PokemonName]?> { get set }
    func viewIsReady()
    func loadPokemons(page: Int)
    func navigateToPokemonDetails(pokemon: Pokemon)
}
