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
    private enum Destination: Hashable {
        case gestures, exclusionList, settings, tipJar
    }

    @State private var isFirstLaunch = InitialDataService.shared.isFirstLaunch ||
        ProcessInfo.processInfo.arguments.contains("SHOW_TUTORIAL")
    @State private var isTutorialPresented = false
    @State private var path: [Destination] = []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                AppHero().frame(maxWidth: .infinity).listRowBackground(Color.clear)
                Section {
                    DisclosureButton(action: { isTutorialPresented = true }) {
                        HomeListItem(
                            title: "HOME_TUTORIAL_TITLE",
                            description: "HOME_TUTORIAL_DESCRIPTION",
                            image: Image(systemName: "checkmark.circle.fill")
                        )
                    }
                }
                Section {
                    NavigationLink(value: Destination.gestures) {
                        HomeListItem(
                            title: "HOME_GESTURES_TITLE",
                            description: "HOME_GESRURES_DESCRIPTION",
                            image: Image(systemName: "hand.draw.fill")
                        )
                    }
                    NavigationLink(value: Destination.exclusionList) {
                        HomeListItem(
                            title: "HOME_EXCLUSION_LIST_TITLE",
                            description: "HOME_EXCLUSION_LIST_DESCRIPTION",
                            image: Image(systemName: "nosign")
                        )
                    }
                }
                Section {
                    NavigationLink(value: Destination.settings) {
                        HomeListItem(
                            title: "HOME_SETTINGS_TITLE",
                            description: "HOME_SETTINGS_DESCRIPTION",
                            image: Image(systemName: "gearshape.fill")
                        )
                    }
                    NavigationLink(value: Destination.tipJar) {
                        HomeListItem(
                            title: "HOME_TIP_JAR_TITLE",
                            description: "HOME_TIP_JAR_DESCRIPTION",
                            image: Image(systemName: "gift.fill")
                        )
                    }
                }
            }
            .navigationTitle("Svadilfari")
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .gestures: GestureListView()
                case .exclusionList: ExclusionListView()
                case .settings: SettingsView()
                case .tipJar: TipJarView()
                }
            }
        }.sheet(isPresented: $isTutorialPresented, content: {
            TutorialView(onOpenGestures: {
                path.append(.gestures)
            })
        }).onAppear(perform: {
            if isFirstLaunch {
                isFirstLaunch = false
                isTutorialPresented = true
            }
        })
    }
}

#Preview {
    HomeListView()
        .environment(IAPStore())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
