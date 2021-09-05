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
                            title: "Start Tutorial",
                            description: "Learn how to use gestures",
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
                            title: "Gestures",
                            description: "Manage gestures and actions",
                            image: Image(systemName: "hand.draw.fill")
                        )
                    })
                    NavigationLink(destination: { ExclusionListView() }, label: {
                        HomeListItem(
                            title: "Exclusion List",
                            description: "Specify websites you don't wish to use gestures",
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
