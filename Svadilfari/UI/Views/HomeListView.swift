//
//  HomeListView.swift
//  HomeListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI
import UIKit
import Foundation

struct HomeListView: View {
    @State private var isFirstLaunch = InitialDataService.shared.isFirstLaunch ||
        ProcessInfo.processInfo.arguments.contains("SHOW_TUTORIAL")
    @State private var isTutorialPresented = false
    @State private var isGesturePresented = false
    var body: some View {
        NavigationView {
            List {
                AppHero().frame(maxWidth: .infinity).listRowBackground(Color.clear)
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
                Section {
                    NavigationLink(destination: { SettingsView() }) {
                        HomeListItem(
                            title: "HOME_SETTINGS_TITLE",
                            description: "HOME_SETTINGS_DESCRIPTION",
                            image: Image(systemName: "gearshape.fill")
                        )
                    }
                }
            }.navigationBarHidden(true)
        }.navigationViewStyle(.stack).sheet(isPresented: $isTutorialPresented, content: {
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
