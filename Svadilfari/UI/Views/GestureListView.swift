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
    private var gestureEntities: FetchedResults<GestureEntity>

    var body: some View {
        List {
            ForEach(self.gestureEntities) { entity in
                if let gesture = entity.gesture {
                    NavigationLink(destination: {
                        EditGestureView(gestureEntity: entity)
                    }, label: {
                        GestureListItem(gesture: gesture)
                    })
                }
            }.onDelete(perform: self.removeGesture)
        }.navigationBarHidden(false)
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
    func removeGesture(offsets: IndexSet) {
        withAnimation {
            offsets.map { self.gestureEntities[$0] }.forEach(self.viewContext.delete)
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
