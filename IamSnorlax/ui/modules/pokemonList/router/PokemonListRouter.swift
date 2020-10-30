//
//  PokemonListRouter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import UIKit

class PokemonListRouter: PresenterToRouterPokemonListProtocol {
    
    // MARK: Variables
    
    static var storyboard: UIStoryboard {
        let storyboard = StoryboardManager.shared.<# StoryboardManager variable #>
        return storyboard
    }
    
    // MARK: Navigation functions
    
    static func navigateToPokemonList(viewController: UIViewController?) {
        guard let navigator = viewController?.navigationController else { return }
        guard let scene: UIViewController = createPokemonListScene(parent: viewController) else { return }
        viewController?.show(scene, sender: navigator)
    }
    
    // MARK: Scene creation functions
    
    static func createPokemonListScene(parent: UIViewController?) -> UIViewController? {
        let navigatorIdentifier: String = "PokemonListNavigationController"
        guard let navigator = storyboard.instantiateViewController(withIdentifier: navigatorIdentifier) as? UINavigationController else { return nil }
        guard let view = navigator.children.first as? PokemonListViewController else { return nil }
        let presenter: ViewToPresenterPokemonListProtocol = PokemonListPresenter()
        let interactor: PresenterToInteractorPokemonListProtocol = PokemonListInteractor()
        let router: PresenterToRouterPokemonListProtocol = PokemonListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
}
