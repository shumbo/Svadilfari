//
//  ActionConfigView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

/**
 Takes an action and present a view to configure the action
 */
struct ActionConfigView: View {
    let action: Action
    let onSelect: (Action) -> Void

    var body: some View {
        if let openURL = action.openURL {
            OpenURLActionConfigView(openURL: openURL, onSelect: self.onSelect)
        } else if let javascriptRun = action.javascriptRun {
            RunJavascriptActionConfigView(javascriptRun: javascriptRun, onSelect: self.onSelect)
        } else {
            EmptyView()
        }
    }
}

struct ActionConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ActionConfigView(
            action: Action(
                openURL: OpenURLAction(
                    newTab: true,
                    title: "Apple",
                    url: "https://apple.com"
                )
            )
        ) { _ in
            // noop
        }
    }
}
