//
//  ActionSelectView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct ActionSelectView: View {
    var onSelect: (Action) -> Void

    var body: some View {
        List {
            Section(LocalizedStringKey("SELECT_ACTION_TABS")) {
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TABS_NEW_TAB")
                }.onTapGesture {
                    self.onSelect(Action(tabOpen: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TABS_CLOSE_TAB")
                }
                .onTapGesture {
                    self.onSelect(Action(tabClose: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TABS_CLOSE_ALL_TABS")
                }
                .onTapGesture {
                    self.onSelect(Action(tabCloseAll: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TABS_DUPLICATE_TAB")
                }
                .onTapGesture {
                    self.onSelect(Action(tabDuplicate: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TABS_NEXT_TAB")
                }
                .onTapGesture {
                    self.onSelect(Action(tabNext: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TABS_PREVIOUS_TAB")
                }
                .onTapGesture {
                    self.onSelect(Action(tabPrevious: true))
                }
            }
            Section(LocalizedStringKey("SELECT_ACTION_PAGE")) {
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_PAGE_RELOAD")
                }
                .onTapGesture {
                    self.onSelect(Action(reload: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_PAGE_COPY_URL")
                }
                .onTapGesture {
                    self.onSelect(Action(urlCopy: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_PAGE_SHARE")
                }
                .onTapGesture {
                    self.onSelect(Action(share: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_PAGE_SCROLL_TO_TOP")
                }
                .onTapGesture {
                    self.onSelect(Action(scrollTop: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_PAGE_SCROLL_TO_BOTTOM")
                }
                .onTapGesture {
                    self.onSelect(Action(scrollBottom: true))
                }
            }
            Section(LocalizedStringKey("SELECT_ACTION_TRANSITION")) {
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TRANSITION_GO_BACKWARD")
                }
                .onTapGesture {
                    self.onSelect(Action(goBackward: true))
                }
                NavigationLinkView {
                    ActionListItem(title: "SELECT_ACTION_TRANSITION_GO_FORWARD")
                }
                .onTapGesture {
                    self.onSelect(Action(goForward: true))
                }
                NavigationLink(destination: {
                    OpenURLActionConfigView(openURL: nil, onSelect: self.onSelect)
                }) {
                    ActionListItem(title: "SELECT_ACTION_TRANSITION_OPEN_URL")
                }
            }
            Section(LocalizedStringKey("SELECT_ACTION_ADVANCED")) {
                NavigationLink(destination: {
                    RunJavascriptActionConfigView(javascriptRun: nil, onSelect: self.onSelect)
                }) {
                    ActionListItem(title: "SELECT_ACTION_ADVANCED_RUN_JAVASCRIPT")
                }
            }
        }
    }
}

private struct ActionListItem: View {
    let title: LocalizedStringKey
    var body: some View {
        HStack {
            Text(self.title)
        }
    }
}

struct ActionSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSelectView(onSelect: { _ in
            // noop
        })
    }
}
