//
//  NewGestureSelectActionView.swift
//  NewGestureSelectActionView
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import SwiftUI

struct NewGestureSelectActionView: View {
    // receive a selected pattern
    let pattern: Pattern
    let fingers: Int

    var body: some View {
        SelectActionView(onSelect: { action in
            print("save gesture")
            let g = Gesture(
                action: action,
                enabled: true,
                fingers: self.fingers,
                id: UUID().uuidString,
                pattern: self.pattern
            )
        })
    }
}

struct NewGestureSelectActionView_Previews: PreviewProvider {
    static var previews: some View {
        NewGestureSelectActionView(pattern: Pattern(data: []), fingers: 1)
    }
}
