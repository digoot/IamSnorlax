//
//  PokemonDetailsPresenter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 28/10/2020.
//

import RxSwift

class PokemonDetailsPresenter: ViewToPresenterPokemonDetailsProtocol {
    // MARK: Variables
    
    var view: PresenterToViewPokemonDetailsProtocol?
    var interactor: PresenterToInteractorPokemonDetailsProtocol?
    var router: PresenterToRouterPokemonDetailsProtocol?
    var pokemon: Pokemon?
    var version: Version?
    var fetchedInfo = ReplaySubject<Pokemon?>.createUnbounded()
    let disposeBag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {
        loadPokemonData()
    }
    
    // MARK: Data fetching
    
    fileprivate func loadPokemonData() {
        guard let id = pokemon?.id else { return }
        interactor?.fetchPokemonDetailsBy(id: id).bind(to: fetchedInfo).disposed(by: disposeBag)
    }
    
}
