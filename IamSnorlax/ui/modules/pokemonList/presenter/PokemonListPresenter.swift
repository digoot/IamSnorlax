//
//  PokemonListPresenter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import RxSwift

class PokemonListPresenter: ViewToPresenterPokemonListProtocol {
    // MARK: Variables

    var view: PresenterToViewPokemonListProtocol?
    var interactor: PresenterToInteractorPokemonListProtocol?
    var router: PresenterToRouterPokemonListProtocol?
    var pokedexes: [Pokedex]?
    var version: Version?
    var pokemons = ReplaySubject<[Pokemon]?>.createUnbounded()
    var pokemonsNames = ReplaySubject<[PokemonName]?>.createUnbounded()
    var fetchedPokemons = [Pokemon]()

    let disposeBag = DisposeBag()

    // MARK: Functions

    func viewIsReady() {
        loadPokedexes()
    }

    // MARK: Data fetching

    fileprivate func loadPokedexes() {
        guard let pokedexes = pokedexes else { return }
        let idsPokedexes = pokedexes.compactMap { $0.id }
        var fetchedPokedexes = [Pokedex]()
        idsPokedexes.forEach { id in
            interactor?.fetchPokedexBy(id: id).subscribe(onNext: { pokedex in
                if let pokedex = pokedex {
                    fetchedPokedexes.append(pokedex)
                }
                if pokedexes.count == fetchedPokedexes.count {
                    self.pokedexes = fetchedPokedexes
                    self.loadPokemons(page: 1)
                }
            }).disposed(by: disposeBag)
        }
    }

    func loadPokemons(page: Int) {
        guard
            page > 0,
            let pokedexes = pokedexes
        else { return }
        let pokemonsPerPage = UIConstants.shared.pokemonsPerPage
        let min = pokemonsPerPage * (page - 1)
        var max = pokemonsPerPage * page - 1
        var fetchedPokemons = [Pokemon]()
        var idPokemons = Array(pokedexes.compactMap { $0.pokemons.compactMap { $0.id } }.joined()).unique()
        idPokemons = idPokemons.sorted(by: { lhs, rhs -> Bool in
            lhs < rhs
        })
        guard min < idPokemons.count else { return }
        if max > idPokemons.count {
            max = idPokemons.count - 1
        }
        for index in min ... max {
            interactor?.fetchPokemonBy(id: idPokemons[index], version: version).subscribe(onNext: { pokemon in
                if let pokemon = pokemon {
                    fetchedPokemons.append(pokemon)
                }
                if fetchedPokemons.count == ((max - min) + 1) {
                    self.pokemons.onNext(fetchedPokemons)
                    self.pokemons.onCompleted()
                }
            }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - Navigations
    
    func navigateToPokemonDetails(pokemon: Pokemon) {
        guard let vc = view as? PokemonListViewController else { return }
        router?.navigateToPokemonDetails(viewController: vc, pokemon: pokemon, version: version)
    }
}
