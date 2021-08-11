//
//  Error.swift
//  Error
//
//  Created by Shun Kashiwa on 2021/08/03.
//

import Foundation

enum EntityError: Error {
    // Invalid JSON in CoreData
    case invalidJson
    // Invalid data structure
    case invalidData
}
