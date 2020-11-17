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
    var pokedexSets: [DataSet]?
    var version: Version?
    var pokedexes = [Pokedex]()
    var pokemons = PublishSubject<[PokemonSpecie]?>()
    var fetchedPokemons = [Pokemon]()

    let disposeBag = DisposeBag()

    // MARK: Functions

    func viewIsReady() {
        loadPokedexes()
    }

    // MARK: Data fetching

    fileprivate func loadPokedexes() {
        guard let pokedexSets = pokedexSets else { return }
        let idsPokedexes = pokedexSets.compactMap({ $0.url.lastPathComponent })
        var fetchedPokedexes = [Pokedex]()
        idsPokedexes.forEach { id in
            interactor?.fetchPokedexBy(id: id).subscribe(onNext: { pokedex in
                if let pokedex = pokedex {
                    fetchedPokedexes.append(pokedex)
                }
                if pokedexSets.count == fetchedPokedexes.count {
                    self.pokedexes = fetchedPokedexes
                    self.loadPokemons(page: 1)
                }
            }).disposed(by: disposeBag)
        }
    }

    func loadPokemons(page: Int) {
        guard page > 0 else { return }
        let pokemonsPerPage = UIConstants.shared.pokemonsPerPage
        let min = pokemonsPerPage * (page - 1)
        var max = pokemonsPerPage * page - 1
        var fetchedPokemons = [PokemonSpecie]()
        var idPokemons = Array(pokedexes.compactMap({ $0.pokemonEntries.compactMap({ $0.entryNumber }) }).joined())
        idPokemons = idPokemons.unique()
        idPokemons = idPokemons.sorted(by: { lhs, rhs -> Bool in
            lhs < rhs
        })
        guard min < idPokemons.count else { return }
        if max > idPokemons.count {
            max = idPokemons.count - 1
        }
        for index in min ... max {
            interactor?.fetchPokemonBy(id: String(idPokemons[index])).subscribe(onNext: { pokemon in
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
    
    func navigateToPokemonDetails(pokemon: PokemonSpecie) {
        guard let vc = view as? PokemonListViewController else { return }
        router?.navigateToPokemonDetails(viewController: vc, pokemon: pokemon)
    }
}
