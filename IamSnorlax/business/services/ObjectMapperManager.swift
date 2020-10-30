//
//  ObjectMapperManager.swift
//  Dogoplay
//
//  Created by Diego Otero Mata on 13/05/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import Alamofire
import Foundation
import ObjectMapper

class ObjectMapperManager<T: Mappable> {
    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {}

    static func deserialize(dataResponse: AFDataResponse<Any>?) -> T? {
        do {
            guard let response = dataResponse else { return nil }
            let value = try response.result.get()
            guard let json = value as? [String: Any] else { return nil }
            return Mapper<T>().map(JSON: json)
        } catch {
            Log.print.error("Unable to get the response value - \(error.localizedDescription)")
            return nil
        }
    }

    static func deserialize(dataResponse: AFDataResponse<Any>?) -> [T]? {
        do {
            guard let response = dataResponse else { return nil }
            let value = try response.result.get()
            guard let json = value as? [[String: Any]] else { return nil }
            return Mapper<T>().mapArray(JSONArray: json)
        } catch {
            Log.print.error("Unable to get the response value - \(error.localizedDescription)")
            return nil
        }
    }

    func describe() -> String {
        return emptyObject()
    }

    func describe(children: [Any]?) -> [String] {
        guard let children = children as? [ObjectMapperManager] else { return [""] }
        return children.compactMap { $0.describe() }
    }

    func describe(child: Any?) -> String {
        guard let child = child as? ObjectMapperManager else { return emptyObject() }
        return child.describe()
    }

    func emptyObject() -> String {
        return "{}"
    }
}
