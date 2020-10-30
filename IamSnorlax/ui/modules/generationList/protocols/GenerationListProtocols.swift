//
//  GameListProtocols.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import UIKit
import RxSwift

// MARK: Protocols for presenter

protocol PresenterToViewGenerationListProtocol: class {
    var presenter: ViewToPresenterGenerationListProtocol? { get set }
}

protocol PresenterToInteractorGenerationListProtocol: class {
    func fetchGenerations() -> PublishSubject<[Generation]?>
}

protocol PresenterToRouterGenerationListProtocol: class {}

// MARK: Protocols for View

protocol ViewToPresenterGenerationListProtocol: class {
    var router: PresenterToRouterGenerationListProtocol? { get set }
    var interactor: PresenterToInteractorGenerationListProtocol? { get set }
    var view: PresenterToViewGenerationListProtocol? { get set }
    func viewIsReady()
}
