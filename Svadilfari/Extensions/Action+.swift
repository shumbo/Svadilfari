//
//  Action+.swift
//  Action+
//
//  Created by Shun Kashiwa on 2021/08/05.
//

import Foundation

extension Action {
    /// true if the action has additional configurations
    public var hasAdditionalConfig: Bool {
        return self.openURL != nil || self.javascriptRun != nil
    }
}
