//
//  GenerationListPresenter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import RxSwift

class GenerationListPresenter: ViewToPresenterGenerationListProtocol {
    // MARK: - Variables

    var view: PresenterToViewGenerationListProtocol?
    var interactor: PresenterToInteractorGenerationListProtocol?
    var router: PresenterToRouterGenerationListProtocol?
    var generations: PublishSubject<[Generation]?> = PublishSubject()

    let disposeBag = DisposeBag()

    // MARK: - Functions

    func viewIsReady() {
        loadGenerations()
    }

    // MARK: - Data fetching

    fileprivate func loadGenerations() {
        interactor?.fetchGenerations().bind(to: generations).disposed(by: disposeBag)
        createSubject()
    }
    
    fileprivate func createSubject() {
        generations = PublishSubject()
    }
    
    // MARK: - Navigations
    
    func navigateToVersionList(groups: [Group]) {
        guard let vc = view as? GenerationListViewController else { return }
        router?.navigateToVersionList(viewController: vc, groups: groups)
    }
}
