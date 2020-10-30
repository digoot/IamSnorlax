//
//  VersionListPresenter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import RxSwift

class VersionListPresenter: ViewToPresenterVersionListProtocol {
    
    // MARK: Variables
    
    var view: PresenterToViewVersionListProtocol?
    var interactor: PresenterToInteractorVersionListProtocol?
    var router: PresenterToRouterVersionListProtocol?
    
    let disposebag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {}
    
    // MARK: Data fetching
    
}
