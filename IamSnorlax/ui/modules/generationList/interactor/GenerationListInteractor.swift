//
//  GenerationListInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import RxSwift

class GenerationListInteractor: PresenterToInteractorGenerationListProtocol {
    var disposeBag = DisposeBag()
    
    func fetchGenerations() -> PublishSubject<[String]?> {
        return GenerationRepository().fetchGenerations()
    }
    
    func fetchGenerationsWith(ids: [String]) -> PublishSubject<[Generation]?> {
        let repository = GenerationRepository()
        let subject = PublishSubject<[Generation]?>()
        var generations = [Generation]()
        ids.forEach{ id in
            repository.fetchGenerationWith(id: id).subscribe(onNext: { generation in
                guard let generation = generation else { return }
                generations.append(generation)
                if generations.count == ids.count {
                    subject.onNext(generations)
                    subject.onCompleted()
                }
            }, onError: { error in
                subject.onError(error)
            }).disposed(by: self.disposeBag)
        }
        return subject
    }
}
