//
//  LocalDataManager.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 11/05/2020.
//

import Foundation
import RealmSwift

public enum DatabaseDebugVerbosity {
    case none
    case all
    case error
    case message
}

enum DBError: Error {
    case instanceNotAvailable, cantSaveObject, deletionFailed, objectNotFound, cantUpdateObject
}

public enum DatabaseWriteType: String {
    case memory = "inMemory"
    case disk = "onDisk"
}

private protocol Databaseable: class {
    static var shared: LocalDataManager { get }
    var instance: Realm? { get }
    func get<T: Object>(type: T.Type) throws -> Results<T>?
    func get<T: Object, K>(type: T.Type, key: K) throws -> T?
    func get<T: Object>(type: T.Type, predicate: NSPredicate, sortBy: String?, ascending: Bool?) throws -> Results<T>?
    func save(_ object: Object) throws
    func save<S: Sequence>(_ objects: S) throws where S.Iterator.Element: Object
    func delete<T: Object>(type: T.Type, predicate: NSPredicate) throws
    func delete(_ objects: [Object]) throws
    func delete(_ object: Object) throws
    func deleteAllData() throws
    func update(_ object: Object, updates: [String: Any]) throws
    func update<T: Object>(_ type: T.Type, updates: [String: Any?]) throws
}

struct DatabaseConfiguration {
    var name: String
    var type: DatabaseWriteType
    var debug: DatabaseDebugVerbosity
    var schemaVersion: UInt64
    var migration: MigrationBlock
}

class LocalDataManager: Databaseable {
    static let shared = LocalDataManager()
    fileprivate var _configuration: DatabaseConfiguration?
    var configuration: DatabaseConfiguration? {
        // Set version for test
        /*
         if AppDelegate.isTestMode() {
             configuration = DatabaseConfiguration(name: "TestDB",
             type: .memory,
             debug: .none,
             schemaVersion: Migrations.shared.schemaVersion,
             migration: Migrations.shared.migrationClosure)
         }
         */
        if _configuration == nil {
            _configuration = DatabaseConfiguration(name: "IamSnorlax",
                                                   type: .disk,
                                                   debug: .all,
                                                   schemaVersion: Migrations.schemaVersion,
                                                   migration: Migrations.block)
            return _configuration
        }
        return _configuration
    }

    fileprivate var _instance: Realm?
    var instance: Realm? {
        if _instance == nil, let configuration = configuration {
            do {
                _instance = try Realm(configuration: configure(configuration))
                if showInfoLog() {
                    Log.print.info(String(describing: configuration))
                }
                if let urlFile = _instance?.configuration.fileURL?.relativePath {
                    if showDebugLog() {
                        Log.print.debug(urlFile)
                    }
                }
                return _instance
            } catch {
                if showErrorLog() {
                    Log.print.error("realm > \(error.localizedDescription)")
                }
            }
        }
        return _instance
    }

    /// Configures the database for its use
    ///
    /// - Parameter configuration: the configuration for the database
    fileprivate func configure(_ configuration: DatabaseConfiguration) throws -> Realm.Configuration {
        var dbConf = Realm.Configuration()
        switch configuration.type {
        case .memory:
            dbConf.fileURL = nil
            dbConf.inMemoryIdentifier = configuration.type.rawValue
        case .disk:
            break
        }
        dbConf.readOnly = false
        dbConf.schemaVersion = configuration.schemaVersion
        dbConf.migrationBlock = configuration.migration
        return dbConf
    }

    /// Instanciates the database
    ///
    /// - Returns: the database itself
    fileprivate func instantiateDb() throws -> Realm {
        guard let instance = instance else {
            if showErrorLog() {
                Log.print.error("Instance not available")
            }
            throw DBError.instanceNotAvailable
        }
        return instance
    }

    /// Get all objects of given type
    ///
    /// - Parameter type: type of object
    /// - Returns: return a result list of type
    internal func get<T>(type: T.Type) throws -> Results<T>? where T: Object {
        let database = try instantiateDb()
        return database.objects(type).elements
    }

    /// Get an object of given type and key
    ///
    /// - Parameter type: object type
    /// - Parameter key: key to filter items
    /// - Returns: return an object
    internal func get<T, K>(type: T.Type, key: K) throws -> T? where T: Object {
        let database = try instantiateDb()
        return database.object(ofType: type, forPrimaryKey: key)
    }

    /// Get all objects of given type and predicate
    ///
    /// - Parameter type: type of object
    /// - Parameter predicate: predicate to filter the query
    /// - Returns: return a result list of type
    internal func get<T>(type: T.Type,
                predicate: NSPredicate,
                sortBy: String?,
                ascending: Bool?) throws -> Results<T>? where T: Object {
        let database = try instantiateDb()
        if let sortBy = sortBy, let ascending = ascending {
            let result = [SortDescriptor(keyPath: sortBy, ascending: ascending)]
            return database.objects(type).filter(predicate).sorted(by: result).elements
        } else {
            return database.objects(type).filter(predicate).elements
        }
    }

    /// Saves an object
    ///
    /// - Parameter object: object item
    internal func save(_ object: Object) throws {
        let database = try instantiateDb()
        do {
            try database.write {
                database.add(object, update: .modified)
            }
        } catch {
            if showErrorLog() {
                Log.print.error("save object > \(error.localizedDescription)")
            }
            throw DBError.cantSaveObject
        }
    }

    /// Saves a sequence of objects
    ///
    /// - Parameter objects: objects to be saved
    internal func save<S>(_ objects: S) throws where S: Sequence, S.Element: Object {
        let database = try instantiateDb()
        do {
            try database.write {
                database.add(objects, update: .modified)
            }
        } catch {
            if showErrorLog() {
                Log.print.error("save sequence > \(error.localizedDescription)")
            }
            throw DBError.cantSaveObject
        }
    }

    /// Delete an object with a given type and a NSPredicate
    ///
    /// - Parameter type: Type of objects to remove
    /// - Parameter predicate: Filter
    internal func delete<T>(type: T.Type, predicate: NSPredicate) throws where T: Object {
        let database = try instantiateDb()
        guard let results = try get(type: type, predicate: predicate, sortBy: nil, ascending: nil) else {
            if showErrorLog() {
                Log.print.error("delete object > No results found")
            }
            throw DBError.objectNotFound
        }
        do {
            try database.write {
                database.delete(results)
            }
        } catch {
            if showErrorLog() {
                Log.print.error("delete object > \(error.localizedDescription)")
            }
            throw DBError.deletionFailed
        }
    }

    /// Deletes objects from an array
    ///
    /// - Parameter objects: array objects of realm type
    internal func delete(_ objects: [Object]) throws {
        let database = try instantiateDb()
        do {
            try database.write {
                database.delete(objects)
            }
        } catch {
            if showErrorLog() {
                Log.print.error("delete objects > \(error.localizedDescription)")
            }
            throw DBError.deletionFailed
        }
    }

    /// Deletes an object
    ///
    /// - Parameter object: object of realm type
    internal func delete(_ object: Object) throws {
        let database = try instantiateDb()
        do {
            try database.write {
                database.delete(object)
            }
        } catch {
            if showErrorLog() {
                Log.print.error("delete object > \(error.localizedDescription)")
            }
            throw DBError.deletionFailed
        }
    }

    /// Deletes all objects of database
    internal func deleteAllData() throws {
        let database = try instantiateDb()
        do {
            database.beginWrite()
            database.deleteAll()
            try database.commitWrite()
        } catch {
            if showErrorLog() {
                Log.print.error("delete all data > \(error.localizedDescription)")
            }
            throw DBError.deletionFailed
        }
    }

    /// Updates an object
    ///
    /// - Parameter object: object of realm type
    /// - Parameter updates: dictionary with all updates to be done on object
    internal func update(_ object: Object, updates: [String: Any]) throws {
        let database = try instantiateDb()
        do {
            try database.write {
                object.setValuesForKeys(updates)
            }
        } catch {
            if showErrorLog() {
                Log.print.error("update > \(error.localizedDescription)")
            }
            throw DBError.cantUpdateObject
        }
    }

    /// Updates an object with a given type and a dictionary with updates
    ///
    /// - Parameter type: Type of object to update
    /// - Parameter updates: dictionary with all updates to be done on object
    internal func update<T: Object>(_ type: T.Type, updates: [String: Any?]) throws {
        let database = try instantiateDb()
        do {
            try database.write {
                database.create(type, value: updates, update: .modified)
            }
        } catch {
            if showErrorLog() {
                Log.print.error("update > \(error.localizedDescription)")
            }
            throw DBError.cantUpdateObject
        }
    }

    /// Error control log for db
    ///
    /// - Parameter error: string error
    fileprivate func showErrorLog() -> Bool {
        return configuration?.debug == .all || configuration?.debug == .error
    }

    /// Debug control log for db
    ///
    /// - Parameter data: string
    fileprivate func showDebugLog() -> Bool {
        return configuration?.debug == .all || configuration?.debug == .message
    }

    /// Info control log for db
    ///
    /// - Parameter data: string
    fileprivate func showInfoLog() -> Bool {
        return configuration?.debug == .all || configuration?.debug == .message || configuration?.debug == .error
    }
}
