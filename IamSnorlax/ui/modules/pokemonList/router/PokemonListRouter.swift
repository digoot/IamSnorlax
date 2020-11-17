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
        let storyboard = StoryboardManager.shared.pokemonList
        return storyboard
    }
    
    // MARK: Navigation functions
    
    static func navigateToPokemonList(viewController: UIViewController?, pokedexes: [DataSet], version: Version) {
        guard
            let navigator = viewController?.navigationController,
            let scene: UIViewController = createPokemonListScene(parent: viewController, pokedexes: pokedexes, version: version)
        else { return }
        navigator.show(scene, sender: viewController)
    }
    
    func navigateToPokemonDetails(viewController: UIViewController, pokemon: PokemonSpecie) {
        PokemonDetailsRouter.navigateToPokemonDetails(viewController: viewController, pokemon: pokemon)
    }
    
    // MARK: Scene creation functions
    
    static func createPokemonListScene(parent: UIViewController?, pokedexes: [DataSet], version: Version) -> UIViewController? {
        guard
            let view = storyboard.instantiateInitialViewController() as? PokemonListViewController
        else { return nil }
        let presenter: ViewToPresenterPokemonListProtocol = PokemonListPresenter()
        let interactor: PresenterToInteractorPokemonListProtocol = PokemonListInteractor()
        let router: PresenterToRouterPokemonListProtocol = PokemonListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.pokedexSets = pokedexes
        presenter.version = version
        
        return view
    }
    
}
