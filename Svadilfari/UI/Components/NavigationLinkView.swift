//
//  NavigationLinkView.swift
//  NavigationLinkView
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import SwiftUI

struct NavigationLinkView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        NavigationLink(
            destination: { EmptyView() },
            label: { content }
        ).contentShape(Rectangle())
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                NavigationLinkView {
                    Text("This adds arrow to any view")
                }
                NavigationLinkView {
                    Text("use onTapGesture for events")
                }
            }.navigationTitle("Some List")
        }
    }
}
