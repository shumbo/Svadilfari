//
//  GestureListItem.swift
//  GestureListItem
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import SwiftUI

struct GestureListItem: View {
    var gesture: Gesture
    var body: some View {
        HStack(alignment: .center) {
            GeometryReader { proxy in
                PatternPreview(
                    frame: proxy.frame(in: .local),
                    pattern: self.gesture.pattern,
                    color: self.gesture.enabled ? UIColor.systemBlue : UIColor.systemGray
                )
            }.frame(width: 44, height: 44).fixedSize()
            Text(self.gesture.action.title)
        }
    }
}

struct GestureListItem_Previews: PreviewProvider {
    static var previews: some View {
        let action1 = Action(
            javascriptRun: JavascriptRun(code: "alert(\"hello world\")", javascriptRunDescription: "Say Hello")
        )
        let pattern1 = Pattern(data: [Vector(x: 0.0, y: 100.0), Vector(x: 100.0, y: 0.0)])
        let gesture1 = Gesture(action: action1, enabled: true, id: "gesture1", pattern: pattern1)
        let action2 = Action(tabNext: true)
        let pattern2 = Pattern(data: [Vector(x: 0.0, y: 100.0), Vector(x: -100.0, y: 0.0)])
        let gesture2 = Gesture(action: action2, enabled: true, id: "gesture2", pattern: pattern2)
        List {
            GestureListItem(gesture: gesture1)
            GestureListItem(gesture: gesture2)
        }.preferredColorScheme(.light)
    }
}
