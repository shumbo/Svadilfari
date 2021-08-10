//
//  Error.swift
//  Error
//
//  Created by Shun Kashiwa on 2021/08/03.
//

import Foundation

enum EntityError: Error {
    // Core Dataに保存されているJSONが違法
    case invalidJson
}
