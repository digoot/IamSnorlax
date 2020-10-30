//
//  GenerationName.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

class GenerationName: Object {
    @objc dynamic var id: Int64 = 0
    @objc dynamic var name: String? = nil
    @objc dynamic var value: String? = nil
}
