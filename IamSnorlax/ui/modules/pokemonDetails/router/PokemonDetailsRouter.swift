//
//  PokemonDetailsRouter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 28/10/2020.
//

import UIKit

class PokemonDetailsRouter: PresenterToRouterPokemonDetailsProtocol {
    
    // MARK: Variables
    
    static var storyboard: UIStoryboard {
        let storyboard = StoryboardManager.shared.<# StoryboardManager variable #>
        return storyboard
    }
    
    // MARK: Navigation functions
    
    static func navigateToPokemonDetails(viewController: UIViewController?) {
        guard let navigator = viewController?.navigationController else { return }
        guard let scene: UIViewController = createPokemonDetailsScene(parent: viewController) else { return }
        viewController?.show(scene, sender: navigator)
    }
    
    // MARK: Scene creation functions
    
    static func createPokemonDetailsScene(parent: UIViewController?) -> UIViewController? {
        let navigatorIdentifier: String = "PokemonDetailsNavigationController"
        guard let navigator = storyboard.instantiateViewController(withIdentifier: navigatorIdentifier) as? UINavigationController else { return nil }
        guard let view = navigator.children.first as? PokemonDetailsViewController else { return nil }
        let presenter: ViewToPresenterPokemonDetailsProtocol = PokemonDetailsPresenter()
        let interactor: PresenterToInteractorPokemonDetailsProtocol = PokemonDetailsInteractor()
        let router: PresenterToRouterPokemonDetailsProtocol = PokemonDetailsRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
}
