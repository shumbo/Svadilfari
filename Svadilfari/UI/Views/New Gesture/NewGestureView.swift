//
//  NewGestureView.swift
//  NewGestureView
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import CoreData
import SwiftUI

struct NewGestureView: View {
    private enum Step: Hashable {
        case selectAction
    }

    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    @State private var path = NavigationPath()
    @State private var pattern: Pattern = Pattern(data: [])

    var body: some View {
        NavigationStack(path: $path) {
            PatternSelectView(path: $path, onSelect: { pattern in
                self.pattern = pattern
                self.path.append(Step.selectAction)
            })
            .navigationTitle("NEW_GESTURE_TITLE")
            .navigationDestination(for: Step.self) { _ in
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
            }
        }
    }
}

#Preview {
    EmptyView().sheet(isPresented: .constant(true)) {
        NewGestureView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
