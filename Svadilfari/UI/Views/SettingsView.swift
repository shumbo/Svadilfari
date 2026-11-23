//
//  SettingsView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaults.Keys.icloudSyncEnabled, store: .shared) private var sync = false
    @AppStorage(UserDefaults.Keys.gestureRecognitionSensitivity, store: .shared) private var sensitivity = 0.0
    @AppStorage(UserDefaults.Keys.gestureRecognitionMouse, store: .shared) private var mouse = false

    var body: some View {
        List {
            Section(
                header: Text("SETTINGS_SYNC_HEADER"),
                footer: Text("SETTINGS_SYNC_FOOTER").fixedSize(horizontal: false, vertical: true)
            ) {
                Toggle("SETTINGS_SYNC_TOGGLE_LABEL", isOn: $sync)
                    .onChange(of: sync) { _, sync in
                        PersistenceController.shared.toggleSync(sync: sync)
                    }
            }
            Section(
                header: Text("SETTINGS_GESTURE_SENSITIVITY_HEADER"),
                footer: Text("SETTINGS_GESTURE_SENSITIVITY_FOOTER")
            ) {
                Slider(
                    value: $sensitivity,
                    in: -3...3,
                    step: 1,
                    minimumValueLabel: Text("SETTINGS_GESTURE_SENSITIVITY_LOW"),
                    maximumValueLabel: Text("SETTINGS_GESTURE_SENSITIVITY_HIGH"),
                    label: {
                        Text("SETTINGS_GESTURE_SENSITIVITY_HEADER")
                    }
                )
            }
            Section(
                header: Text("SETTINGS_GESTURE_MOUSE_HEADER"),
                footer: Text("SETTINGS_GESTURE_MOUSE_FOOTER").fixedSize(horizontal: false, vertical: true)
            ) {
                Toggle("SETTINGS_GESTURE_MOUSE_TOGGLE_LABEL", isOn: $mouse)
            }
            Section(header: Text("SETTINGS_LINKS_HEADER")) {
                Link("SETTINGS_LINKS_ABOUT_APP", destination: URL(string: "https://go.svadilfari.app/about")!)
                Link("SETTINGS_LINKS_FAQ", destination: URL(string: "https://go.svadilfari.app/faq")!)
                Link("SETTINGS_LINKS_CONTACT", destination: URL(string: "https://go.svadilfari.app/contact")!)
            }
        }.navigationTitle("SETTINGS_TITLE")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
