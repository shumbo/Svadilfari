//
//  SettingsView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct SettingsView: View {
    @State private var sensitivity: Double = 0.0

    var body: some View {
        List {
            Section(
                header: Text("SETTINGS_GESTURE_SENSITIVITY_HEADER"),
                footer: Text("SETTINGS_GESTURE_SENSITIVITY_FOOTER")
            ) {
                Slider(
                    value: $sensitivity.onChange { nv in
                        UserDefaults.shared.set(nv, forKey: UserDefaults.Keys.gestureRecognitionSensitivity)
                    },
                    in: -3...3,
                    step: 1,
                    minimumValueLabel: Text("SETTINGS_GESTURE_SENSITIVITY_LOW"),
                    maximumValueLabel: Text("SETTINGS_GESTURE_SENSITIVITY_HIGH"),
                    label: {
                    Text("SETTINGS_GESTURE_SENSITIVITY_HEADER")
                    }
                ).onAppear {
                    self.sensitivity = UserDefaults.shared.double(
                        forKey: UserDefaults.Keys.gestureRecognitionSensitivity
                    )
                }
            }
            Section(header: Text("SETTINGS_LINKS_HEADER")) {
                Link("SETTINGS_LINKS_ABOUT_APP", destination: URL(string: "https://www.svadilfari.app")!)
                Link("SETTINGS_LINKS_FAQ", destination: URL(string: "https://www.svadilfari.app")!)
                Link("SETTINGS_LINKS_CONTACT", destination: URL(string: "https://www.svadilfari.app")!)
            }
        }.navigationTitle("SETTINGS_TITLE")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
