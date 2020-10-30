//
//  VersionAssembler.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Foundation

final class VersionAssembler {
    static func assemble(
        dataSets: [DataSetApiObject]?,
        group: Group?
    ) -> [Version]? {
        guard let dataSets = dataSets else { return nil }
        return dataSets.compactMap { set in
            guard
                let urlString = set.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let version = Version(id: id)
            version.group = group
            return version
        }
    }
    
    static func assemble(
        _ apiObject: VersionApiObject,
        dao: VersionDao
    ) {
        let groupDb = getVersionFromDb(dao: dao, id: apiObject.id)
        let version = assembleVersion(
            apiObject: apiObject,
            versionDb: groupDb
        )
        if let names = assembleNames(apiObject: apiObject) {
            version?.names.replace(with: names)
        }
        if let version = version, dao.create(version) {
            Log.print.debug("Updated Group \(version.id)")
        }
    }
    
    static fileprivate func assembleVersion(
        apiObject: VersionApiObject,
        versionDb: Version?
    ) -> Version? {
        guard
            let id = apiObject.id
        else { return nil }
        if let version = versionDb {
            return version
        } else {
            let version = Version(id: id)
            return version
        }
    }
    
    static fileprivate func assembleNames(
        apiObject: VersionApiObject
    ) -> [VersionName]? {
        guard let names = apiObject.names else { return nil }
        return names.compactMap{ nameApiObject in
            guard
                let versionId = apiObject.id,
                let urlString = nameApiObject.language?.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let name = VersionName(id: "\(id)-\(versionId)", languageId: id)
            name.locale = nameApiObject.language?.name
            name.value = nameApiObject.name
            return name
        }
    }

    // MARK: - Database fetches

    static fileprivate func getVersionFromDb(dao: VersionDao?, id: Int64?) -> Version? {
        return dao?.read(id)?.unmanaged()
    }
    
}
