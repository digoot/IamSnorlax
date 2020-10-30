//
//  GenerationListPresenter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import RxSwift
//import RxDataSources

class GenerationListPresenter: ViewToPresenterGenerationListProtocol {
    
    // MARK: Variables
    
    var view: PresenterToViewGenerationListProtocol?
    var interactor: PresenterToInteractorGenerationListProtocol?
    var router: PresenterToRouterGenerationListProtocol?
    let disposebag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {
        loadGenerations()
    }
    
    // MARK: Data fetching
    
    func loadGenerations() {
        interactor?.fetchGenerations().subscribe(onNext: { generations in
            generations?.forEach({ generation in
                Log.print.debug(generation)
            })
        }).disposed(by: disposebag)
    }
    
}
