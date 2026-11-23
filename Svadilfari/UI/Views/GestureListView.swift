//
//  GestureListView.swift
//  GestureListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI
import CoreData

struct GestureListView: View {
    @State private var newGestureSheetPresented = false

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
        }.navigationTitle("GESTURE_LIST_TITLE")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        self.newGestureSheetPresented = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }.sheet(isPresented: $newGestureSheetPresented) {
                NewGestureView()
            }
    }
    func removeGesture(offsets: IndexSet) {
        withAnimation {
            offsets.map { self.gestureEntities[$0] }.forEach(self.viewContext.delete)
            try? self.viewContext.save()
        }
    }
}

#Preview {
    NavigationStack {
        GestureListView()
    }
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
