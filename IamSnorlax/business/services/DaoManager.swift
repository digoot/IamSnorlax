//
//  DaoManager.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 11/05/2020.
//

import Foundation
import RealmSwift

// TODO: Change return by nilable objects
class DaoManager<T: Object> {
    var database: LocalDataManager?

    init(_ instance: LocalDataManager? = nil) {
        guard instance != nil else {
            database = LocalDataManager.shared
            return
        }
        database = instance
    }
    
    func create(_ object: T) -> Bool {
        do {
            try database?.save(object)
            return true
        } catch {
            Log.print.error(error.localizedDescription)
            return false
        }
    }

    func create(_ objects: [T]) -> Bool {
        do {
            try database?.save(objects)
            return true
        } catch {
            Log.print.error(error.localizedDescription)
            return false
        }
    }

    func read<K>(_ key: K) -> T? {
        do {
            return try database?.get(type: T.self, key: key)
        } catch {
            Log.print.error(error.localizedDescription)
            return nil
        }
    }

    func read() -> [T]? {
        do {
            guard let results = try database?.get(type: T.self) else { return nil }
            return Array(results)
        } catch {
            Log.print.error(error.localizedDescription)
            return nil
        }
    }

    func read(_ predicate: NSPredicate, sortBy: String? = nil, ascending: Bool? = nil) -> [T]? {
        do {
            guard
                let results = try database?.get(type: T.self, predicate: predicate, sortBy: sortBy,
                                                ascending: ascending)
            else { return nil }
            return Array(results)
        } catch {
            Log.print.error(error.localizedDescription)
            return nil
        }
    }
    
    func update(_ object: T, updates: [String: Any?]) -> Bool {
        do {
            var updates = updates
            let mirror = Mirror(reflecting: object)
            let schema = object.objectSchema
            guard
                let primaryKeyLabel = (schema.primaryKeyProperty?.name),
                let primaryKeyValue = (mirror.children.filter{ $0.label == primaryKeyLabel }.first?.value)
            else { throw DBError.cantUpdateObject }
            updates[primaryKeyLabel] = primaryKeyValue
            try database?.update(T.self, updates: updates)
            return true
        } catch {
            Log.print.error(error.localizedDescription)
            return false
        }
    }

    func delete(_ predicate: NSPredicate) -> Bool {
        do {
            try database?.delete(type: T.self, predicate: predicate)
            return true
        } catch {
            Log.print.error(error.localizedDescription)
            return false
        }
        
    }

    func delete(_ objects: [T]) -> Bool {
        do {
            try database?.delete(objects)
            return true
        } catch {
            Log.print.error(error.localizedDescription)
            return false
        }
    }
}
