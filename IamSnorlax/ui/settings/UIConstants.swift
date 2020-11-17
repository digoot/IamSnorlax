//
//  UIConstants.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 18/05/2020.
//

import Foundation
import UIKit

struct Font {
    private var size: CGFloat
    init(ofSize size: CGFloat) {
        self.size = size
    }
    func build() -> UIFont? {
        return UIFont(name: "pokemon-font", size: size)
    }
}

class UIConstants {
    static let shared = UIConstants()

    // MARK: - Background Color settings
    
    let backgroundColor = UIColor(named: "background") ?? UIColor.white
    
    // MARK: - Number of Pokemons per page
    
    let pokemonsPerPage = 20
    
    // MARK: - Locale
    
    let locale = NSLocale.current.languageCode
    
    // MARK: - No data
    
    let noData = "??????"
    
    private init() {}
}
