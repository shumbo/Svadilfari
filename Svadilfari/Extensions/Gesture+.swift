//
//  Gesture+.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/07.
//

import Foundation
import SwiftUI

// conform Changeable to add `change` method
extension Gesture: Changeable {}

extension Gesture {
    var contentHash: Int {
        // in case of an error, generate a random string to avoid unintended collision
        let pattern = try? self.pattern.jsonString() ?? UUID().uuidString
        let action = try? self.action.jsonString() ?? UUID().uuidString
        var hasher = Hasher()
        hasher.combine(pattern)
        hasher.combine(action)
        hasher.combine(self.enabled)
        return hasher.finalize()
    }
}
