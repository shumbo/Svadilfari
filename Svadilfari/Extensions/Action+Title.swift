//
//  Gesture+Title.swift
//  Gesture+Title
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import Foundation

extension Action {
    var title: String {
        if self.tabOpen != nil {
            return "Open Tab"
        }
        if self.tabClose != nil {
            return "Close Tab"
        }
        if self.tabCloseAll != nil {
            return "Close All Tabs"
        }
        if self.tabDuplicate != nil {
            return "Duplicate Tab"
        }
        if self.tabNext != nil {
            return "Next Tab"
        }
        if self.tabPrevious != nil {
            return "Previous Tab"
        }
        if self.reload != nil {
            return "Reload"
        }
        if let a = self.javascriptRun {
            if let d = a.javascriptRunDescription, d != "" {
                return "Run JavaScript (\(d))"
            }
            return "Run JavaScript"
        }
        if self.urlCopy != nil {
            return "Copy URL"
        }
        if self.scrollTop != nil {
            return "Scroll to Top"
        }
        if self.scrollBottom != nil {
            return "Scroll to Bottom"
        }
        return "Unknown Action"
    }
}
