//
//  SettingsView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct SettingsView: View {
    @State private var sync: Bool = true
    @State private var sensitivity: Double = 0.0

    var body: some View {
        List {
            Section(footer: Text("SETTINGS_SYNC_FOOTER")) {
                Toggle("SETTINGS_SYNC_TOGGLE_LABEL", isOn: self.$sync.onChange { nv in
                    UserDefaults.shared.icloudSyncEnabled = nv
                    PersistenceController.shared.toggleSync(sync: nv)
                }).onAppear {
                    self.sync = UserDefaults.shared.icloudSyncEnabled
                }
            }
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
                Link("SETTINGS_LINKS_ABOUT_APP", destination: URL(string: "https://go.svadilfari.app/about")!)
                Link("SETTINGS_LINKS_FAQ", destination: URL(string: "https://go.svadilfari.app/faq")!)
                Link("SETTINGS_LINKS_CONTACT", destination: URL(string: "https://go.svadilfari.app/contact")!)
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
