//
//  StoryBoardManager.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import UIKit

class StoryboardManager {
    // MARK: - Variables
    static let shared = StoryboardManager()
    
    let generationList: UIStoryboard
    
    // MARK: - Constructor
    private init() {
        generationList = UIStoryboard(name: "GenerationList", bundle: nil)
    }
    
}
