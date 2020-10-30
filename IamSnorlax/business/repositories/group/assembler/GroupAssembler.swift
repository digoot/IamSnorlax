//
//  GroupAssembler.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Foundation

final class GroupAssembler {
    static func assemble(
        dataSets: [DataSetApiObject]?
    ) -> [Group]? {
        guard let dataSets = dataSets else { return nil }
        return dataSets.compactMap { set in
            guard
                let urlString = set.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let group = Group(id: id)
            group.name = set.name
            return group
        }
    }
    
    static func assemble(
        _ apiObject: GroupApiObject,
        dao: GroupDao
    ) {
        let groupDb = getGroupFromDb(dao: dao, id: apiObject.id)
        let group = assembleGroup(
            apiObject: apiObject,
            groupDb: groupDb
        )
        if let pokedexes = PokedexAssembler.assemble(dataSets: apiObject.pokedexes) {
            group?.pokedexes.replace(with: pokedexes)
        }
        if let versions = VersionAssembler.assemble(dataSets: apiObject.versions, group: group) {
            group?.versions.replace(with: versions)
        }
        if let group = group, dao.create(group) {
            Log.print.debug("Updated Group \(group.id)")
        }
    }
    
    static fileprivate func assembleGroup(
        apiObject: GroupApiObject,
        groupDb: Group?
    ) -> Group? {
        guard
            let id = apiObject.id,
            let name = apiObject.name
        else { return nil }
        if let group = groupDb {
            return group
        } else {
            let group = Group(id: id)
            group.name = name
            return group
        }
    }

    // MARK: - Database fetches

    static fileprivate func getGroupFromDb(dao: GroupDao?, id: Int64?) -> Group? {
        return dao?.read(id)?.unmanaged()
    }
    
}
