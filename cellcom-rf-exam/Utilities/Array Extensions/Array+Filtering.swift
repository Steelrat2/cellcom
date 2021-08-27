//
//  Array+Filtering.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import Foundation

public extension Array where Element: Hashable {
    static func removeDuplicates(_ elements: [Element]) -> [Element] {
        var seen = Set<Element>()
        return elements.filter{ seen.insert($0).inserted }
    }
}
