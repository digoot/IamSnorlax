//
//  GenerationListInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import RxSwift

class GenerationListInteractor: PresenterToInteractorGenerationListProtocol {
    var disposeBag = DisposeBag()
    func fetchGenerations() -> PublishSubject<[Generation]?> {
        let subject = PublishSubject<[Generation]?>()
        let repository = GenerationRepository()
        repository.fetchGenerations().subscribe(onNext: { ids in
            guard let ids = ids else {
                return subject.onError(IASError.init(title: "No", messages: nil, code: nil))
            }
            var generations = [Generation]()
            ids.forEach{ id in
                repository.fetchGenerationWith(id: id).subscribe(onNext: { generation in
                    guard let generation = generation else { return }
                    generations.append(generation)
                }).disposed(by: self.disposeBag)
            }
            subject.onNext(generations)
            subject.onCompleted()
        }).disposed(by: disposeBag)
        return subject
    }
}
