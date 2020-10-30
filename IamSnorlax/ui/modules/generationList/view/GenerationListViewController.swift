//
//  GameListViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import UIKit

class GameListViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: ViewToPresenterGameListProtocol?
    
    // MARK: Outlets
    
    // MARK: Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewIsReady()
    }
    
    // MARK: Functions
    
    func setupView() {
        
    }
}

extension GameListViewController: PresenterToViewGameListProtocol {
    
}
