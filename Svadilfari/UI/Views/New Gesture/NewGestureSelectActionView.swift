//
//  NewGestureSelectActionView.swift
//  NewGestureSelectActionView
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import SwiftUI

struct NewGestureSelectActionView: View {
    @EnvironmentObject private var sheetState: SheetState

    @Environment(\.managedObjectContext) private var viewContext

    // receive a selected pattern
    let pattern: Pattern

    var body: some View {
        SelectActionView(onSelect: { action in
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
            self.sheetState.presented = false
        })
    }
}

struct NewGestureSelectActionView_Previews: PreviewProvider {
    static var previews: some View {
        NewGestureSelectActionView(pattern: Pattern(data: []))
    }
}
