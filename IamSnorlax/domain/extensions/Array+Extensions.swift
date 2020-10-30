//
//  Array+Extensions.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 30/10/2020.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
}
