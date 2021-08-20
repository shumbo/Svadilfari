//
//  Logger+.swift
//  Logger+
//
//  Created by Shun Kashiwa on 2021/08/20.
//

import Foundation
import os

private let subsystem = "dev.shun-k.Svadilfari"

extension Logger {
    static let coreData = Logger(subsystem: subsystem, category: "CoreData")
}
