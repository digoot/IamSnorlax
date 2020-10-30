//
//  Migrations.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 11/05/2020.
//

import RealmSwift

class Migrations {
    static let shared = Migrations()

    static let schemaVersion: UInt64 = 0

    static let block: (Migration, UInt64) -> Void = { migration, oldSchemaVersion in
        if oldSchemaVersion < 1 {}
    }
}
