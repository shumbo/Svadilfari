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

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: GestureEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "createdAt", ascending: false)
        ],
        predicate: nil,
        animation: .default
    )
    private var gestures: FetchedResults<GestureEntity>

    var body: some View {
        List {
            ForEach(gestures) { (g: GestureEntity) in
                if let gesture = g.gesture {
                    GestureListItem(gesture: gesture, onChangeEnabled: {_ in
                        toggleGestureEnabled(g: g)
                    })
                }
            }.onDelete(perform: self.removeGesture)
        }
            .navigationBarHidden(false)
            .navigationBarTitle("GESTURE_LIST_TITLE")
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

    func toggleGestureEnabled(g: GestureEntity) {
        guard let gesture = g.gesture else {
            return
        }
        let newGesture = Gesture(
            action: gesture.action,
            enabled: !gesture.enabled,
            id: gesture.id,
            pattern: gesture.pattern
        )
        self.viewContext.performAndWait {
            g.gesture = newGesture
            try? self.viewContext.save()
        }
    }
    func removeGesture(offsets: IndexSet) {
        withAnimation {
            offsets.map { self.gestures[$0] }.forEach(self.viewContext.delete)
            try? self.viewContext.save()
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
