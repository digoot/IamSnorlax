//
//  VersionListProtocols.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import UIKit
import RxSwift

// MARK: Protocols for presenter

protocol PresenterToViewVersionListProtocol: class {
    var presenter : ViewToPresenterVersionListProtocol? { get set }
}

protocol PresenterToInteractorVersionListProtocol : class {
    
}

protocol PresenterToRouterVersionListProtocol : class {
    
}

// MARK: Protocols for View

protocol ViewToPresenterVersionListProtocol : class {
    var router: PresenterToRouterVersionListProtocol? { get set }
    var interactor: PresenterToInteractorVersionListProtocol? { get set }
    var view: PresenterToViewVersionListProtocol? { get set }
    func viewIsReady()
}
