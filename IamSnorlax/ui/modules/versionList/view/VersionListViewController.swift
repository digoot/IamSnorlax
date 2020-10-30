//
//  VersionListViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import UIKit

class VersionListViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: ViewToPresenterVersionListProtocol?
    
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

extension VersionListViewController: PresenterToViewVersionListProtocol {
    
}
