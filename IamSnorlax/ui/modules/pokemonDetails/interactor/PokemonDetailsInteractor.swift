//
//  PokemonDetailsInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 28/10/2020.
//

import Foundation
import RxSwift

class PokemonDetailsInteractor: PresenterToInteractorPokemonDetailsProtocol {
    func fetchPokemonDetailsBy(id: String) -> PublishSubject<Pokemon?> {
        return PokemonRepository().fetchPokemonDetailsBy(id: id)
    }
}
