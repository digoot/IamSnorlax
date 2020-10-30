//
//  Migrations.swift
//  Dogoplay
//
//  Created by Diego Otero Mata on 11/05/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import RealmSwift

class Migrations {
    static let shared = Migrations()

    static let schemaVersion: UInt64 = 0

    static let block: (Migration, UInt64) -> Void = { migration, oldSchemaVersion in
        if oldSchemaVersion < 1 {}
    }
}
