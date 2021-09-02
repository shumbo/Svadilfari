//
//  HomeListView.swift
//  HomeListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI
import UIKit

struct HomeListView: View {
    @State private var selection: NavigationSelection?
    enum NavigationSelection: Hashable {
        case none
        case tutorial
        case gestures
        case exclusionList
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(tag: NavigationSelection.tutorial, selection: $selection, destination: {
                        TutorialView(onOpenGestures: {
                            // TODO: Retrieve 0.35 from somewhere
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                selection = .gestures
                            }
                        }).navigationBarTitleDisplayMode(.inline)
                    }, label: {
                        HomeListItem(
                            title: "Start Tutorial",
                            description: "Learn how to use gestures",
                            image: Image(systemName: "checkmark.circle.fill")
                        )
                    })
                }
                Section {
                    NavigationLink(tag: NavigationSelection.gestures, selection: $selection, destination: {
                        GestureListView()
                    }, label: {
                        HomeListItem(
                            title: "Gestures",
                            description: "Manage gestures and actions",
                            image: Image(systemName: "hand.draw.fill")
                        )
                    }).listRowInsets(HomeListItem.listRowInsets)
                    NavigationLink(
                        tag: NavigationSelection.exclusionList,
                        selection: $selection,
                        destination: { ExclusionListView() },
                        label: {
                            HomeListItem(
                                title: "Exclusion List",
                                description: "Specify websites you don't wish to use gestures",
                                image: Image(systemName: "nosign")
                            )
                        }
                    )
                }
            }.navigationBarHidden(true)
        }.navigationViewStyle(.columns)
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
