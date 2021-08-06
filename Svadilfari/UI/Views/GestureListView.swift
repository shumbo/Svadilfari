//
//  GestureListView.swift
//  GestureListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI
import CoreData

struct GestureListView: View {
    @State private var showingNewGestureView = false

    /*
    @FetchRequest(entity: GestureEntity.entity(), sortDescriptors: [], predicate: nil, animation: .default)
    private var gestures: FetchedResults<GestureEntity>
     */

    var body: some View {
        Text("Hello World")
            .navigationBarHidden(false)
            .navigationBarTitle("Gesture")
            .navigationBarItems(trailing: Button(action: {
                self.showingNewGestureView = true
            }) {
                Image(systemName: "plus")
            }).sheet(isPresented: $showingNewGestureView) {
                NavigationView {
                    NewGestureView()
                }
            }
    }
}

struct GestureListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GestureListView()
        }
    }
}
