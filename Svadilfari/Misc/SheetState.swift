//
//  SheetState.swift
//  SheetState
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import Foundation
import SwiftUI

class SheetState: ObservableObject {
    init() {
        self.presented = false
    }
    @Published var presented: Bool
}
