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
    var pokemon: PokemonSpecie?
    var fetchedInfo = PublishSubject<Pokemon?>()
    let disposeBag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {
        loadPokemonData()
    }
    
    // MARK: Data fetching
    
    fileprivate func loadPokemonData() {
        guard let id = pokemon?.id else { return }
        interactor?.fetchPokemonDetailsBy(id: String(id)).bind(to: fetchedInfo).disposed(by: disposeBag)
    }
    
}
