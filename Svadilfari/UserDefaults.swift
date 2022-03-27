//
//  UserDefaults.swift
//  UserDefaults
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import Foundation

extension UserDefaults {
    /// shared instance that can be accessed from all targets
    static var shared: UserDefaults = {
        let instance = UserDefaults(suiteName: APP_GROUP_ID)!
        UserDefaults.setInitialData(defaults: instance)
        return instance
    }()

    /// Set initial data to a specified UserDefault instance
    static public func setInitialData(defaults: UserDefaults) {
        defaults.register(defaults: userDefaultsDefaults)
    }

    static private let userDefaultsDefaults = [
        Keys.previouslyLaunched: false,
        Keys.gestureRecognitionSensitivity: 0.0,
        Keys.icloudSyncEnabled: false
    ] as [String: Any]

    public enum Keys {
        static let previouslyLaunched = "previouslyLaunched"
        static let gestureRecognitionSensitivity = "gestureRecognitionSensitivity"
        static let icloudSyncEnabled = "icloudSyncEnabled"
    }

    var isFirstLaunch: Bool {
        // to get `true` on the first launch, get/set inverted values
        get {
            return !self.bool(forKey: Keys.previouslyLaunched)
        }
        set {
            self.setValue(!newValue, forKey: Keys.previouslyLaunched)
        }
    }

    var icloudSyncEnabled: Bool {
        get {
            return self.bool(forKey: Keys.icloudSyncEnabled)
        }
        set {
            self.setValue(newValue, forKey: Keys.icloudSyncEnabled)
        }
    }
}
