//
//  GenerationListRouter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import UIKit

class GenerationListRouter: PresenterToRouterGenerationListProtocol {
    
    // MARK: Variables
    
    static var storyboard: UIStoryboard {
        let storyboard = StoryboardManager.shared.generationList
        return storyboard
    }
    
    // MARK: Navigation functions
    
    static func navigateToGameList(viewController: UIViewController?) {
        guard let navigator = viewController?.navigationController else { return }
        guard let scene: UIViewController = createGameListScene(parent: viewController) else { return }
        viewController?.show(scene, sender: navigator)
    }
    
    // MARK: Scene creation functions
    
    static func createGameListScene(parent: UIViewController?) -> UIViewController? {
        guard
            let navigator = storyboard.instantiateInitialViewController() as? UINavigationController,
            let view = navigator.children.first as? GenerationListViewController
        else { return nil }
        let presenter: ViewToPresenterGenerationListProtocol = GenerationListPresenter()
        let interactor: PresenterToInteractorGenerationListProtocol = GenerationListInteractor()
        let router: PresenterToRouterGenerationListProtocol = GenerationListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
}
