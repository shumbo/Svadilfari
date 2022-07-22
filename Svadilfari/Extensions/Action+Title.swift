//
//  Gesture+Title.swift
//  Gesture+Title
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import Foundation
import SwiftUI

extension Action {
    var title: LocalizedStringKey {
        if self.tabOpen != nil {
            return "ACTION_TITLE_OPEN_TAB"
        }
        if self.tabClose != nil {
            return "ACTION_TITLE_CLOSE_TAB"
        }
        if self.tabCloseAll != nil {
            return "ACTION_TITLE_CLOSE_ALL_TABS"
        }
        if self.tabDuplicate != nil {
            return "ACTION_TITLE_DUPLICATE_TAB"
        }
        if self.tabNext != nil {
            return "ACTION_TITLE_NEXT_TAB"
        }
        if self.tabPrevious != nil {
            return "ACTION_TITLE_PREVIOUS_TAB"
        }
        if self.reload != nil {
            return "ACTION_TITLE_RELOAD"
        }
        if let a = self.javascriptRun {
            if let d = a.javascriptRunDescription, d != "" {
                return "ACTION_TITLE_RUN_JAVASCRIPT \(d)"
            }
            return "ACTION_TITLE_RUN_JAVASCRIPT"
        }
        if self.urlCopy != nil {
            return "ACTION_TITLE_COPY_URL"
        }
        if self.scrollTop != nil {
            return "ACTION_TITLE_SCROLL_TO_TOP"
        }
        if self.scrollBottom != nil {
            return "ACTION_TITLE_SCROLL_TO_BOTTOM"
        }
        if self.goForward != nil {
            return "ACTION_TITLE_GO_FORWARD"
        }
        if self.goBackward != nil {
            return "ACTION_TITLE_GO_BACKWARD"
        }
        if let a = self.openURL {
            if a.title != "" {
                return "ACTION_TITLE_OPEN_URL \(a.title)"
            }
            return "ACTION_TITLE_OPEN_URL"
        }
        if self.share != nil {
            return "ACTION_TITLE_SHARE"
        }
        return "ACTION_TITLE_UNKNOWN"
    }

    var shortTitle: LocalizedStringKey {
        if let a = self.openURL {
            if a.title != "" {
                return LocalizedStringKey(a.title)
            }
        }
        if let a = self.javascriptRun, let b = a.javascriptRunDescription {
            if b != "" {
                return LocalizedStringKey(b)
            }
        }
        return self.title
    }
}
