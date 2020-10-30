//
//  GenerationAssembler.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Foundation

final class GenerationAssembler {
    // MARK: - Api assemblers

    static func assemble(
        list: ListApiObject
    ) -> [Int64]? {
        guard let dataSets = list.results else { return nil }
        return dataSets.compactMap { set in
            guard let urlString = set.url, let url = URL(string: urlString) else { return nil }
            return Int64(url.lastPathComponent)
        }
    }

    static func assemble(
        _ apiObject: GenerationApiObject,
        dao: GenerationDao
    ) {
        let generationDb = getGenerationFromDb(dao: dao, id: apiObject.id)
        let generation = assembleGeneration(
            apiObject: apiObject,
            generationDb: generationDb
        )
        if let names = assembleNames(apiObject: apiObject) {
            generation?.names.replace(with: names)
        }
        if let groups = GroupAssembler.assemble(dataSets: apiObject.versionGroups) {
            generation?.groups.replace(with: groups)
        }
        if let generation = generation, dao.create(generation) {
            Log.print.debug("Updated Generartion \(generation.id)")
        }
    }

    static fileprivate func assembleGeneration(
        apiObject: GenerationApiObject,
        generationDb: Generation?
    ) -> Generation? {
        guard
            let id = apiObject.id
        else { return nil }
        if let generation = generationDb {
            return generation
        } else {
            let generation = Generation(id: id)
            return generation
        }
    }
    
    static fileprivate func assembleNames(
        apiObject: GenerationApiObject
    ) -> [GenerationName]? {
        guard let names = apiObject.names else { return nil }
        return names.compactMap{ nameApiObject in
            guard
                let generationId = apiObject.id,
                let urlString = nameApiObject.language?.url,
                let url = URL(string: urlString),
                let id = Int64(url.lastPathComponent)
            else { return nil }
            let name = GenerationName(id: "\(id)-\(generationId)", languageId: id)
            name.locale = nameApiObject.language?.name
            name.value = nameApiObject.name
            return name
        }
    }

    // MARK: - Database fetches

    static fileprivate func getGenerationFromDb(dao: GenerationDao?, id: Int64?) -> Generation? {
        return dao?.read(id)?.unmanaged()
    }
}
