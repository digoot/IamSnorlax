//
//  Sequence+Extensions.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 30/10/2020.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
