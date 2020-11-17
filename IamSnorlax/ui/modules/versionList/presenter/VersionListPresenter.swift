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
    var generation: Generation?
    var versions = PublishSubject<[Version]?>()
    var groups = [Group]()
    
    let disposeBag = DisposeBag()
    
    // MARK: Functions
    
    func viewIsReady() {
        loadGroups()
    }
    
    // MARK: Data fetching
    
    fileprivate func loadGroups() {
        let idsGroups = generation?.versionGroups?.compactMap({ $0.url.lastPathComponent })
        var fetchedGroups = [Group]()
        idsGroups?.forEach({ id in
            interactor?.fetchGroupBy(id: id).subscribe(onNext: { group in
                if let group = group {
                    fetchedGroups.append(group)
                }
                if idsGroups?.count == fetchedGroups.count {
                    self.groups.append(contentsOf: fetchedGroups)
                    self.loadVersions()
                }
            }).disposed(by: disposeBag)
        })
    }
    
    fileprivate func loadVersions() {
        let idVersions = Array(groups.compactMap{ $0.versions.compactMap{ $0.url.lastPathComponent } }.joined())
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
    
    func navigateToPokemonList(version: Version) {
        guard
            let vc = view as? VersionListViewController,
            let pokedexes = groups.filter({ $0.name == version.group.name }).first?.pokedexes
        else { return }
        router?.navigateToPokemonList(viewController: vc, pokedexes: pokedexes, version: version)
    }
}
