//
//  PatternSelectDrawerView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI
import JavaScriptCore

struct PatternSelectDrawerView<Content: View>: View {
    var onSelect: (Pattern) -> Void
    let content: () -> Content

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
            }, header: { Text("DRAW_PATTERN_TITLE") }, footer: { Text("DRAW_PATTERN_FOOTER") }).onAppear {
                self.line = []
            }
        }.background(NavigationLink(isActive: $nextPageVisible, destination: {
            if let pattern = pattern {
                PatternSelectConfirmView(pattern: pattern, onSelect: self.onSelect, content: self.content)
            } else {
                EmptyView()
            }
        }, label: { EmptyView() })).navigationTitle("DRAW_PATTERN_TITLE")
    }
}

struct PatternSelectDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PatternSelectDrawerView(onSelect: { _ in
                // noop
            }) {
                EmptyView()
            }
        }
    }
}
