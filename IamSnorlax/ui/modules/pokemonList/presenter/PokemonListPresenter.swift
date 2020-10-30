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
    
    let disposebag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {}
    
    // MARK: Data fetching
    
}
