//
//  Gesture+Title.swift
//  Gesture+Title
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import Foundation

extension Action {
    var title: String {
        get {
            if self.tabClose != nil {
                return "Close Tab"
            }
            if self.tabNext != nil {
                return "Next Tab"
            }
            if self.tabPrevious != nil {
                return "Previous Tab"
            }
            if self.reload != nil {
                return "Reload Tab"
            }
            if let a = self.runJavascript {
                if let d = a.runJavaScriptActionDescription {
                    return "Run JavaScript (\(d))"
                }
                return "Run JavaScript"
            }
            return "Unknown Action"
        }
    }
}
