//
//  Sequence-Sorting.swift
//  UltimatePortfolio
//
//  Created by David Hughes on 17/03/2021.
//

import Foundation

extension Sequence {
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted {
            $0[keyPath: keyPath] < $1[keyPath: keyPath]
        }
    }
}
