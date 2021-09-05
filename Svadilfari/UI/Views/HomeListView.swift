//
//  HomeListView.swift
//  HomeListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI
import UIKit

struct HomeListView: View {
    @State private var isFirstLaunch = InitialDataService.shared.isFirstLaunch
    @State private var isTutorialPresented = false
    @State private var isGesturePresented = false
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: EmptyView()) {
                        HomeListItem(
                            title: "HOME_TUTORIAL_TITLE",
                            description: "HOME_TUTORIAL_DESCRIPTION",
                            image: Image(systemName: "checkmark.circle.fill")
                        )
                    }.contentShape(Rectangle())
                        .onTapGesture {
                            isTutorialPresented = true
                        }
                }
                Section {
                    NavigationLink(isActive: $isGesturePresented, destination: { GestureListView() }, label: {
                        HomeListItem(
                            title: "HOME_GESTURES_TITLE",
                            description: "HOME_GESRURES_DESCRIPTION",
                            image: Image(systemName: "hand.draw.fill")
                        )
                    })
                    NavigationLink(destination: { ExclusionListView() }, label: {
                        HomeListItem(
                            title: "HOME_EXCLUSION_LIST_TITLE",
                            description: "HOME_EXCLUSION_LIST_DESCRIPTION",
                            image: Image(systemName: "nosign")
                        )
                    })
                }
            }.navigationBarHidden(true)
        }.navigationViewStyle(.columns).sheet(isPresented: $isTutorialPresented, content: {
            TutorialView(onOpenGestures: {
                self.isGesturePresented = true
            })
        }).onAppear(perform: {
            if isFirstLaunch {
                isFirstLaunch = false
                isTutorialPresented = true
            }
        })
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
