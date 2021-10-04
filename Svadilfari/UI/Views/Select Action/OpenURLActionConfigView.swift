//
//  OpenURLActionConfigView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/03.
//

import SwiftUI

struct OpenURLActionConfigView: View {
    @State private var url: String = ""
    @State private var title: String = ""
    @State private var newTab: Bool = true

    let onSelect: SelectActionView.SelectActionCallback
    var body: some View {
        Form {
            Section(header: Text("OPEN_URL_CONFIG_HEADER_1"), footer: Text("OPEN_URL_CONFIG_FOOTER_1")) {
                TextField("https://apple.com", text: $url, prompt: nil).keyboardType(.URL)
            }
            Section(header: Text("OPEN_URL_CONFIG_HEADER_2")) {
                TextField("URL Title", text: $title, prompt: Text("Apple"))
            }
            Section(
                header: Text("OPEN_URL_CONFIG_HEADER_3"),
                footer: Text(newTab ? "OPEN_URL_CONFIG_MSG_NEW_TAB": "OPEN_URL_CONFIG_MSG_SAME_TAB")) {
                Toggle("OPEN_URL_CONFIG_TOGGLE_NEW_TAB", isOn: $newTab)
            }
            Button(
                action: {
                    let openURL = OpenURLAction(newTab: self.newTab, title: self.title, url: self.url)
                    let action = Action(openURL: openURL)
                    onSelect(action)
                },
                label: {
                    Text("COMMON_CONTINUE").bold().frame(maxWidth: .infinity)
                }
            ).buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
        }.navigationTitle("OPEN_URL_CONFIG_TITLE")
    }
}

struct OpenURLActionConfigView_Previews: PreviewProvider {
    static var previews: some View {
        OpenURLActionConfigView(onSelect: { action in
            print("selected: \(action.label)")
        })
    }
}
