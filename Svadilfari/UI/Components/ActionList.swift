//
//  ActionList.swift
//  ActionList
//
//  Created by Shun Kashiwa on 2021/08/05.
//

import SwiftUI

struct ActionList: View {

    var body: some View {
        List {
            Section("Tabs") {
                ActionListItem(title: "New Tab").onTapGesture {
                    print("hello")
                }
                ActionListItem(title: "Close Tab").onTapGesture {
                    print("hello")
                }
            }
            Section("Advanced") {
                ActionListItem(title: "Run JavaScript").onTapGesture {
                    print("hello")
                }
            }
        }.navigationTitle("Actions")
    }
}

struct ActionList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActionList()
        }
    }
}

private struct ActionListItem: View {
    let title: String
    var body: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                Text(self.title)
            }
        }.contentShape(Rectangle())
    }
}
