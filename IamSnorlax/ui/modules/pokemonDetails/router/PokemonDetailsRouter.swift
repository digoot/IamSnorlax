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
        let storyboard = StoryboardManager.shared.pokemonDetails
        return storyboard
    }
    
    // MARK: Navigation functions
    
    static func navigateToPokemonDetails(viewController: UIViewController?, pokemon: PokemonSpecie) {
        guard
            let navigator = viewController?.navigationController,
            let scene: UIViewController = createPokemonDetailsScene(parent: viewController, pokemon: pokemon)
        else { return }
        navigator.show(scene, sender: viewController)
    }
    
    // MARK: Scene creation functions
    
    static func createPokemonDetailsScene(parent: UIViewController?, pokemon: PokemonSpecie) -> UIViewController? {
        guard
            let view = storyboard.instantiateInitialViewController() as? PokemonDetailsViewController
        else { return nil }
        let presenter: ViewToPresenterPokemonDetailsProtocol = PokemonDetailsPresenter()
        let interactor: PresenterToInteractorPokemonDetailsProtocol = PokemonDetailsInteractor()
        let router: PresenterToRouterPokemonDetailsProtocol = PokemonDetailsRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.pokemon = pokemon
        
        return view
    }
    
}
