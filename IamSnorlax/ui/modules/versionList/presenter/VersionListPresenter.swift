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
    var groups: [Group]?
    var versions = ReplaySubject<[Version]?>.createUnbounded()
    
    let disposeBag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {
        loadGroups()
    }
    
    // MARK: Data fetching
    
    fileprivate func loadGroups() {
        guard let groups = groups else { return }
        let idsGroups = groups.compactMap{ $0.id }
        var fetchedGroups = [Group]()
        idsGroups.forEach({ id in
            interactor?.fetchGroupBy(id: id).subscribe(onNext: { group in
                if let group = group {
                    fetchedGroups.append(group)
                }
                if groups.count == fetchedGroups.count {
                    self.groups = fetchedGroups
                    self.loadVersions()
                }
            }).disposed(by: disposeBag)
        })
    }
    
    fileprivate func loadVersions() {
        guard let groups = groups else { return }
        let idVersions = Array(groups.compactMap({ $0.versions.compactMap{ $0.id } }).joined())
        var fetchedVersions = [Version]()
        idVersions.forEach({ id in
            interactor?.fetchVersionBy(id: id).subscribe(onNext: { version in
                if let version = version {
                    fetchedVersions.append(version)
                }
                if idVersions.count == fetchedVersions.count {
                    self.versions.onNext(fetchedVersions)
                    self.versions.onCompleted()
                }
            }).disposed(by: disposeBag)
        })
    }
    
    // MARK: - Navigations
    
    func navigateToPokemonList(pokedexes: [Pokedex], version: Version?) {
        guard let vc = view as? VersionListViewController else { return }
        router?.navigateToPokemonList(viewController: vc, pokedexes: pokedexes, version: version)
    }
}
