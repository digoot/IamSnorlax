//
//  PokemonDetailsViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 28/10/2020.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: ViewToPresenterPokemonDetailsProtocol?
    
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

extension PokemonDetailsViewController: PresenterToViewPokemonDetailsProtocol {
    
}
