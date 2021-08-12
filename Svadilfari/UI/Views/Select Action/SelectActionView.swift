//
//  SelectActionView.swift
//  SelectActionView
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import SwiftUI

struct SelectActionView: View {
    public typealias SelectActionCallback = (Action) -> Void

    let onSelect: SelectActionCallback
    var body: some View {
        List {
            Section("Tabs") {
                NavigationLinkView {
                    ActionListItem(title: "New Tab")
                }.onTapGesture {
                    // TODO
                }
                NavigationLinkView {
                    ActionListItem(title: "Close Tab")
                }
                .onTapGesture {
                    self.onSelect(
                        Action(
                            tabClose: true
                        )
                    )
                }
            }
            Section("Advanced") {
                NavigationLink(destination: {
                    RunJavascriptActionConfigView(onSelect: self.onSelect)
                }) {
                    ActionListItem(title: "Run JavaScript")
                }
            }
        }.navigationTitle("Action")
    }
}

struct SelectActionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectActionView(onSelect: { action in
                print("Selected \(action.label)")
            })
        }
    }
}

private struct ActionListItem: View {
    let title: String
    var body: some View {
        HStack {
            Text(self.title)
        }
    }
}
