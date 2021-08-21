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
                    self.onSelect(Action(tabOpen: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Close Tab")
                }
                .onTapGesture {
                    self.onSelect(Action(tabClose: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Close All Tabs")
                }
                .onTapGesture {
                    self.onSelect(Action(tabCloseAll: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Duplicate Tab")
                }
                .onTapGesture {
                    self.onSelect(Action(tabDuplicate: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Next Tab")
                }
                .onTapGesture {
                    self.onSelect(Action(tabNext: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Previous Tab")
                }
                .onTapGesture {
                    self.onSelect(Action(tabPrevious: true))
                }
            }
            Section("Current Page") {
                NavigationLinkView {
                    ActionListItem(title: "Reload")
                }
                .onTapGesture {
                    self.onSelect(Action(reload: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Copy URL")
                }
                .onTapGesture {
                    self.onSelect(Action(urlCopy: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Scroll to Top")
                }
                .onTapGesture {
                    self.onSelect(Action(scrollTop: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "Scroll to Bottom")
                }
                .onTapGesture {
                    self.onSelect(Action(scrollBottom: true))
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
