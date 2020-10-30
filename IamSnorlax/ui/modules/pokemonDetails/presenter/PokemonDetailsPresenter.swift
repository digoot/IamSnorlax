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
    
    let disposebag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {}
    
    // MARK: Data fetching
    
}
