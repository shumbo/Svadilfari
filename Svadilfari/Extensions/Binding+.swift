//
//  Binding+.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
