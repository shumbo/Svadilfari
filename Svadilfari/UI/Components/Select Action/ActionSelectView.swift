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
                DisclosureButton(action: { self.onSelect(Action(tabOpen: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TABS_NEW_TAB")
                }
                DisclosureButton(action: { self.onSelect(Action(tabClose: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TABS_CLOSE_TAB")
                }
                DisclosureButton(action: { self.onSelect(Action(tabCloseAll: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TABS_CLOSE_ALL_TABS")
                }
                DisclosureButton(action: { self.onSelect(Action(tabDuplicate: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TABS_DUPLICATE_TAB")
                }
                DisclosureButton(action: { self.onSelect(Action(tabNext: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TABS_NEXT_TAB")
                }
                DisclosureButton(action: { self.onSelect(Action(tabPrevious: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TABS_PREVIOUS_TAB")
                }
            }
            Section(LocalizedStringKey("SELECT_ACTION_PAGE")) {
                DisclosureButton(action: { self.onSelect(Action(reload: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_PAGE_RELOAD")
                }
                DisclosureButton(action: { self.onSelect(Action(urlCopy: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_PAGE_COPY_URL")
                }
                DisclosureButton(action: { self.onSelect(Action(scrollTop: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_PAGE_SCROLL_TO_TOP")
                }
                DisclosureButton(action: { self.onSelect(Action(scrollBottom: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_PAGE_SCROLL_TO_BOTTOM")
                }
            }
            Section(LocalizedStringKey("SELECT_ACTION_TRANSITION")) {
                DisclosureButton(action: { self.onSelect(Action(goBackward: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TRANSITION_GO_BACKWARD")
                }
                DisclosureButton(action: { self.onSelect(Action(goForward: true)) }) {
                    ActionListItem(title: "SELECT_ACTION_TRANSITION_GO_FORWARD")
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

#Preview {
    ActionSelectView(onSelect: { _ in
        // noop
    })
}
