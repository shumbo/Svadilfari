//
//  SettingsView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct SettingsView: View {
    @State private var sensitivity: Double = 5.0
    @State private var hapticFeedback: Bool = false

    var body: some View {
        List {
            Section(header: Text("Sensitivity"), footer: Text("ジェスチャーの感度を変更できます。感度を高めるとジェスチャーが認識されやすくなりますが、誤検知もしやすくなります。")) {
                Slider(
                    value: $sensitivity.onChange { nv in
                        UserDefaults.shared.set(nv, forKey: UserDefaults.Keys.gestureRecognitionSensitivity)
                    },
                    in: 1...10,
                    step: 2,
                    minimumValueLabel: Text("低い"),
                    maximumValueLabel: Text("高い"),
                    label: {
                    Text("Sensitivity")
                    }
                ).onAppear {
                    self.sensitivity = UserDefaults.shared.double(
                        forKey: UserDefaults.Keys.gestureRecognitionSensitivity
                    )
                }
            }
            Section {
                Toggle("Haptic Feedback", isOn: $hapticFeedback.onChange({ nv in
                    UserDefaults.shared.set(
                        nv,
                        forKey: UserDefaults.Keys.gestureHapticFeedback
                    )
                })).onAppear {
                    self.hapticFeedback = UserDefaults.shared.bool(
                        forKey: UserDefaults.Keys.gestureHapticFeedback
                    )
                }
            }
            Section("リンク") {
                Link("このアプリについて", destination: URL(string: "https://www.svadilfari.app")!)
                Link("よくある質問", destination: URL(string: "https://www.svadilfari.app")!)
                Link("お問い合わせ", destination: URL(string: "https://www.svadilfari.app")!)
            }
        }.navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
