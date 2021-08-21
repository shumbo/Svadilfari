//
//  NewGestureDrawerView.swift
//  NewGestureDrawerView
//
//  Created by Shun Kashiwa on 2021/08/14.
//

import SwiftUI
import JavaScriptCore

struct NewGestureDrawerView: View {
    @State private var line: [CGPoint] = []
    @State private var nextPageVisible = false
    @State private var pattern: Pattern?

    var body: some View {
        Form {
            Section(content: {
                Canvas { context, _ in
                    // draw a line
                    var path = Path()
                    path.addLines(self.line)
                    context.stroke(path, with: .color(.accentColor), lineWidth: 2)
                }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged { value in
                    let p = value.location
                    if value.translation.width == 0 && value.translation.height == 0 {
                        self.line = []
                    }
                    self.line.append(p)
                }.onEnded { _ in
                    let points: PointList = self.line.map { Point(x: $0.x, y: $0.y) }
                    guard let pointListStr = try? points.jsonString() else {
                        return
                    }
                    guard let context = JSContext() else {
                        return
                    }
                    let path = Bundle.main.path(forResource: "NativeHelper", ofType: ".js")
                    guard let script = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8) else {
                        return
                    }
                    context.evaluateScript(script)
                    let result = context.evaluateScript("S.pointsToPattern('\(pointListStr)')")
                    guard let jsonStr = result?.toString() else {
                        return
                    }
                    guard let pattern = try? Pattern(jsonStr) else {
                        return
                    }
                    self.pattern = pattern
                    self.nextPageVisible = true
                }).frame(minHeight: 300)
            }, header: { Text("Draw Pattern") }, footer: { Text("Draw the pattern you want to use") }).onAppear {
                self.line = []
            }
        }.background(NavigationLink(isActive: $nextPageVisible, destination: {
            // TODO: Is this legal? Shouldn't I be using Binding?
            if let pattern = pattern {
                NewGesturePatternConfirmView(pattern: pattern)
            } else {
                EmptyView()
            }
        }, label: { EmptyView() })).navigationTitle("Draw Pattern")
    }
}

struct NewGestureDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        NewGestureDrawerView()
    }
}
