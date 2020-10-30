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
    func fetchGroupBy(id: Int64) -> ReplaySubject<Group?>
    func fetchVersionBy(id: Int64) -> ReplaySubject<Version?>
}

protocol PresenterToRouterVersionListProtocol: class {
    func navigateToPokemonList(viewController: UIViewController, pokedexes: [Pokedex], version: Version?)
}

// MARK: Protocols for View

protocol ViewToPresenterVersionListProtocol: class {
    var router: PresenterToRouterVersionListProtocol? { get set }
    var interactor: PresenterToInteractorVersionListProtocol? { get set }
    var view: PresenterToViewVersionListProtocol? { get set }
    var groups: [Group]? { get set }
    var versions: ReplaySubject<[Version]?> { get set }
    func viewIsReady()
    func navigateToPokemonList(pokedexes: [Pokedex], version: Version?)
}
