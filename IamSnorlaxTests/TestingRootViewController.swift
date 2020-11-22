//
//  TestingRootViewController.swift
//  IamSnorlaxTests
//
//  Created by Diego Otero Mata on 22/11/2020.
//

import UIKit

class TestingRootViewController: UIViewController {

    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .white

        view = label
    }
}
