//
//  PokemonListInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import Foundation
import RxSwift

class PokemonListInteractor: PresenterToInteractorPokemonListProtocol {
    func fetchPokedexBy(id: Int64) -> ReplaySubject<Pokedex?> {
        return PokedexRepository().fetchPokedexBy(id: id)
    }
    func fetchPokemonBy(id: Int64, version: Version?) -> ReplaySubject<Pokemon?> {
        return PokemonRepository().fetchPokemonBy(id: id, version: version)
    }
    func fetchPokemonNamesBy(ids: [Int64], locale: String) -> ReplaySubject<[PokemonName]?> {
        return PokemonRepository().fetchPokemonNamesBy(ids: ids, locale: locale)
    }
}
