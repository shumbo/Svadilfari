//
//  Action+.swift
//  Action+
//
//  Created by Shun Kashiwa on 2021/08/05.
//

import Foundation

extension Action {
    var label: String {
        if self.reload != nil {
            return "Reload"
        }
        if self.tabClose != nil {
            return "Close Tab"
        }
        if self.tabNext != nil {
            return "Next Tab"
        }
        if self.tabPrevious != nil {
            return "Previous Tab"
        }
        if self.runJavascript != nil {
            return "Run JavaScript"
        }
        return "Unknown Action"
    }
}
