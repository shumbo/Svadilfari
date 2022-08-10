//
//  NewGestureView.swift
//  NewGestureView
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import SwiftUI

struct NewGestureView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    @State private var actionVisible: Bool = false
    @State private var pattern: Pattern = Pattern(data: [])

    var body: some View {
        NavigationView {
            PatternSelectView(onSelect: { pattern in
                self.pattern = pattern
                self.actionVisible = true
            }) {
                NavigationLink(
                    isActive: $actionVisible,
                    destination: {
                        SelectActionView { action in
                            let id = UUID()
                            let g = Gesture(
                                action: action,
                                enabled: true,
                                id: id.uuidString,
                                pattern: self.pattern
                            )
                            let e = GestureEntity(context: self.viewContext)
                            e.json = try? g.jsonString()
                            e.createdAt = Date()
                            e.updatedAt = Date()
                            e.id = id
                            try? self.viewContext.save()
                            self.dismiss()
                        }.navigationTitle("SELECT_ACTION_TITLE")
                    }, label: {
                        EmptyView()
                    }
                )
            }.navigationTitle("NEW_GESTURE_TITLE")
        }
    }
}

struct NewGestureView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView().sheet(isPresented: .constant(true), content: {
            NavigationView {
                NewGestureView()
            }}
        )
    }
}
