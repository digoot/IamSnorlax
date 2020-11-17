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
    var generations: PublishSubject<[Generation]?>

    let disposeBag = DisposeBag()
    
    init() {
        generations = PublishSubject()
    }

    // MARK: - Functions

    func viewIsReady() {
        loadGenerationsIds()
    }

    // MARK: - Data fetching

    fileprivate func loadGenerationsIds() {
        interactor?.fetchGenerations().subscribe(onNext: { ids in
            guard let ids = ids else {
                self.generations.onError(IASError(title: "Error fetching ids", messages: nil, code: nil))
                return
            }
            self.loadGenerationsWith(ids: ids)
        }, onError: { _ in
            
        }).disposed(by: disposeBag)
    }
    
    fileprivate func loadGenerationsWith(ids: [String]) {
        interactor?.fetchGenerationsWith(ids: ids).bind(to: generations).disposed(by: disposeBag)
    }
    
    // MARK: - Navigations
    
    func navigateToVersionList(generation: Generation) {
        guard let vc = view as? GenerationListViewController else { return }
        router?.navigateToVersionList(viewController: vc, generation: generation)
    }
}
