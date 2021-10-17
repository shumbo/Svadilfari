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

    let openURL: OpenURLAction?
    let onSelect: SelectActionView.SelectActionCallback

    var body: some View {
        Form {
            Section(header: Text("OPEN_URL_CONFIG_HEADER_1"), footer: Text("OPEN_URL_CONFIG_FOOTER_1")) {
                TextField("https://apple.com", text: $url, prompt: nil).keyboardType(.URL).onAppear {
                    self.url = self.openURL?.url ?? ""
                }
            }
            Section(header: Text("OPEN_URL_CONFIG_HEADER_2")) {
                TextField("URL Title", text: $title, prompt: Text("Apple")).onAppear {
                    self.title = self.openURL?.title ?? ""
                }
            }
            Section(
                header: Text("OPEN_URL_CONFIG_HEADER_3"),
                footer: Text(newTab ? "OPEN_URL_CONFIG_MSG_NEW_TAB": "OPEN_URL_CONFIG_MSG_SAME_TAB")) {
                    Toggle("OPEN_URL_CONFIG_TOGGLE_NEW_TAB", isOn: $newTab).onAppear {
                        self.newTab = self.openURL?.newTab ?? true
                    }
            }
            Button(
                action: {
                    let openURL = OpenURLAction(newTab: self.newTab, title: self.title, url: self.url)
                    let action = Action(openURL: openURL)
                    onSelect(action)
                },
                label: {
                    Text(self.openURL == nil ? "COMMON_CONTINUE" : "COMMON_SAVE")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
            ).buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
        }.navigationTitle("OPEN_URL_CONFIG_TITLE")
            .interactiveDismissDisabled()
    }
}

struct OpenURLActionConfigView_Previews: PreviewProvider {
    static var previews: some View {
        OpenURLActionConfigView(openURL: nil, onSelect: { action in
            print("selected: \(action.title)")
        })
    }
}
