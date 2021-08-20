//
//  HomeListView.swift
//  HomeListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI

struct HomeListView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: EmptyView()) {
                        HomeListItem(
                            title: "Start Tutorial",
                            description: "Learn how to use gestures",
                            image: Image(systemName: "checkmark.circle.fill")
                        )
                    }.contentShape(Rectangle())
                        .onTapGesture {
                            NotificationCenter.default.post(name: .NSPersistentStoreRemoteChange, object: nil)
                        print("TODO")
                    }
                }
                Section {
                    NavigationLink(destination: GestureListView()) {
                        HomeListItem(
                            title: "Gestures",
                            description: "Manage gestures and actions",
                            image: Image(systemName: "hand.draw.fill")
                        )
                    }.listRowInsets(HomeListItem.listRowInsets)
                    NavigationLink(destination: ExclusionListView()) {
                        HomeListItem(
                            title: "Exclusion List",
                            description: "Specify websites you don't wish to use gestures",
                            image: Image(systemName: "nosign")
                        )
                    }
                }
            }.navigationBarHidden(true)
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
