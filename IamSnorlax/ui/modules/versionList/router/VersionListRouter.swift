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
        let storyboard = StoryboardManager.shared.versionList
        return storyboard
    }
    
    // MARK: Navigation functions
    
    static func navigateToVersionList(viewController: UIViewController?, generation: Generation) {
        guard
            let navigator = viewController?.navigationController,
            let scene: UIViewController = createVersionListScene(parent: viewController, generation: generation)
        else { return }
        navigator.show(scene, sender: viewController)
    }
    
    func navigateToPokemonList(viewController: UIViewController, pokedexes: [DataSet], version: Version) {
        PokemonListRouter.navigateToPokemonList(viewController: viewController, pokedexes: pokedexes, version: version)
    }
    
    // MARK: Scene creation functions
    
    static func createVersionListScene(parent: UIViewController?, generation: Generation) -> UIViewController? {
        guard
            let view = storyboard.instantiateInitialViewController() as? VersionListViewController
        else { return nil }
        let presenter: ViewToPresenterVersionListProtocol = VersionListPresenter()
        let interactor: PresenterToInteractorVersionListProtocol = VersionListInteractor()
        let router: PresenterToRouterVersionListProtocol = VersionListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.generation = generation
        
        return view
    }
    
}
