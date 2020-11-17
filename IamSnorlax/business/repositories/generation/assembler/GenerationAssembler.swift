//
//  GenerationAssembler.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/10/2020.
//

import Foundation

final class GenerationAssembler {
    // MARK: - Api assemblers

    static func assemble(data: Data?) -> [String]? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        do {
            let list = try decoder.decode(List.self, from: data)
            return list.results?.compactMap({ set in
                return set.url.lastPathComponent
            })
        } catch let error {
            Log.print.error(error)
            return nil
        }
    }
    
    static func assemble(data: Data?) -> Generation? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Generation.self, from: data)
        } catch let error {
            Log.print.error(error)
            return nil
        }
    }
}
