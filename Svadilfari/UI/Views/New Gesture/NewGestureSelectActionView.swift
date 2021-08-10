//
//  NewGestureSelectActionView.swift
//  NewGestureSelectActionView
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import SwiftUI

struct NewGestureSelectActionView: View {
    @EnvironmentObject private var sheetState: SheetState

    // receive a selected pattern
    let pattern: Pattern
    let fingers: Int

    var body: some View {
        SelectActionView(onSelect: { action in
            let id = UUID()
            let g = Gesture(
                action: action,
                enabled: true,
                fingers: self.fingers,
                id: id.uuidString,
                pattern: self.pattern
            )
            self.sheetState.presented = false
        })
    }
}

struct NewGestureSelectActionView_Previews: PreviewProvider {
    static var previews: some View {
        NewGestureSelectActionView(pattern: Pattern(data: []), fingers: 1)
    }
}
