//
//  GestureListView.swift
//  GestureListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI
import CoreData

struct GestureListView: View {
    @StateObject private var newGestureState = SheetState()

    @FetchRequest(entity: GestureEntity.entity(), sortDescriptors: [], predicate: nil, animation: .default)
    private var gestures: FetchedResults<GestureEntity>

    var body: some View {
        Text("Hello World")
            .navigationBarHidden(false)
            .navigationBarTitle("Gesture")
            .navigationBarItems(trailing: Button(action: {
                self.newGestureState.presented = true
            }) {
                Image(systemName: "plus")
            }).sheet(isPresented: Binding(
                get: { self.newGestureState.presented },
                set: { self.newGestureState.presented = $0 }
            )) {
                NavigationView {
                    NewGestureView()
                }.environmentObject(self.newGestureState)
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
