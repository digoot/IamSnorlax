//
//  String+Extensions.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 21/10/2020.
//

import Foundation
import UIKit

extension String {
    func indexesOf(substring: String) -> [Int] {
        var indexes = [Int]()
        var searchStartIndex = startIndex
        while searchStartIndex < endIndex,
            let range = self.range(of: substring, range: searchStartIndex ..< endIndex),
            !range.isEmpty {
            let index = distance(from: startIndex, to: range.lowerBound)
            indexes.append(index)
            searchStartIndex = range.upperBound
        }
        return indexes
    }

    func replaceTokenBy(_ token: String, _ args: [String]) -> String {
        var indexes = indexesOf(substring: token)
        var result = self
        guard
            args.count <= indexes.count
        else {
            fatalError("The number of elements to be replaced are different")
        }
        guard args.count == indexes.count else {
            if let last = indexes.last {
                let start = self.index(result.startIndex, offsetBy: last)
                let end = self.index(result.startIndex, offsetBy: last + token.count)
                result.replaceSubrange(start ..< end, with: "")
                return result
            }
            fatalError("The number of elements to be replaced are different")
        }
        args.reversed().forEach { arg in
            guard let last = indexes.last else { return }
            let start = self.index(result.startIndex, offsetBy: last)
            let end = self.index(result.startIndex, offsetBy: last + token.count)
            result.replaceSubrange(start ..< end, with: arg)
            indexes = Array(indexes.dropLast())
        }
        return result
    }

}
