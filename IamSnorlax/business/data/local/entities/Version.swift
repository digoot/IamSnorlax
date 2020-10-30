//
//  Games.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Foundation
import RealmSwift

class Version: Object {
    @objc dynamic var id: Int64 = 0
    internal var name: LocatedGameName?
}
