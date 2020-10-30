//
//  VersionListRouter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import UIKit

class VersionListRouter: PresenterToRouterVersionListProtocol {
    
    // MARK: Variables
    
    static var storyboard: UIStoryboard {
        let storyboard = StoryboardManager.shared.<# StoryboardManager variable #>
        return storyboard
    }
    
    // MARK: Navigation functions
    
    static func navigateToVersionList(viewController: UIViewController?) {
        guard let navigator = viewController?.navigationController else { return }
        guard let scene: UIViewController = createVersionListScene(parent: viewController) else { return }
        viewController?.show(scene, sender: navigator)
    }
    
    // MARK: Scene creation functions
    
    static func createVersionListScene(parent: UIViewController?) -> UIViewController? {
        let navigatorIdentifier: String = "VersionListNavigationController"
        guard let navigator = storyboard.instantiateViewController(withIdentifier: navigatorIdentifier) as? UINavigationController else { return nil }
        guard let view = navigator.children.first as? VersionListViewController else { return nil }
        let presenter: ViewToPresenterVersionListProtocol = VersionListPresenter()
        let interactor: PresenterToInteractorVersionListProtocol = VersionListInteractor()
        let router: PresenterToRouterVersionListProtocol = VersionListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
}
