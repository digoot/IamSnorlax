//
//  PokemonListInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import Foundation
import RxSwift

class PokemonListInteractor: PresenterToInteractorPokemonListProtocol {
    func fetchPokedexBy(id: String) -> PublishSubject<Pokedex?> {
        return PokedexRepository().fetchPokedexBy(id: id)
    }
    func fetchPokemonBy(id: String) -> PublishSubject<PokemonSpecie?> {
        return PokemonRepository().fetchPokemonBy(id: id)
    }
}
