//
//  MovieError.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import Foundation

enum MovieError: Error {
    case parsing(description: String)
    case network(description: String)
}
