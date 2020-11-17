//
//  VersionListProtocols.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import RxSwift
import UIKit

// MARK: Protocols for presenter

protocol PresenterToViewVersionListProtocol: class {
    var presenter: ViewToPresenterVersionListProtocol? { get set }
}

protocol PresenterToInteractorVersionListProtocol: class {
    func fetchGroupBy(id: String) -> PublishSubject<Group?>
    func fetchVersionBy(id: String) -> PublishSubject<Version?>
}

protocol PresenterToRouterVersionListProtocol: class {
    func navigateToPokemonList(viewController: UIViewController, pokedexes: [DataSet], version: Version)
}

// MARK: Protocols for View

protocol ViewToPresenterVersionListProtocol: class {
    var router: PresenterToRouterVersionListProtocol? { get set }
    var interactor: PresenterToInteractorVersionListProtocol? { get set }
    var view: PresenterToViewVersionListProtocol? { get set }
    var generation: Generation? { get set }
    var versions: PublishSubject<[Version]?> { get set }
    func viewIsReady()
    func navigateToPokemonList(version: Version)
}
