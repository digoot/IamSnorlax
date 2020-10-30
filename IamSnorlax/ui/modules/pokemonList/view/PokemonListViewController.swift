//
//  PokemonListViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: ViewToPresenterPokemonListProtocol?
    
    // MARK: Outlets
    
    // MARK: Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewIsReady()
    }
    
    // MARK: Functions
    
    func setupView() {
        <# code #>
    }
}

extension PokemonListViewController: PresenterToViewPokemonListProtocol {
    
}
