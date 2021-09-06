//
//  NewGesturePresetsView.swift
//  NewGesturePresetsView
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import SwiftUI

struct NewGesturePresetsView: View {
    var body: some View {
        List {
            ForEach(presets) { preset in
                NavigationLink(destination: NewGesturePatternConfirmView(pattern: preset.pattern)) {
                    HStack {
                        GeometryReader { proxy in
                            PatternPreview(frame: proxy.frame(in: .local), pattern: preset.pattern)
                        }.frame(width: 44, height: 44).fixedSize()
                        Text(preset.name)
                    }
                }
            }
        }.navigationTitle("SELECT_PATTERN_TITLE")
    }
}

struct NewGesturePresetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewGesturePresetsView()
        }
    }
}

private struct Preset: Identifiable {
    var id: UUID = UUID()
    let name: String
    let pattern: Pattern
}

private let TOP = Vector(x: 0.0, y: -100.0)
private let LEFT = Vector(x: -100.0, y: 0.0)
private let RIGHT = Vector(x: 100.0, y: 0.0)
private let BOTTOM = Vector(x: 0.0, y: 100.0)

private let presets: [Preset] = [
    Preset(
        name: "Top Left",
        pattern: Pattern(data: [TOP, LEFT])
    ),
    Preset(
        name: "Top Right",
        pattern: Pattern(data: [TOP, RIGHT])
    ),
    Preset(
        name: "Bottom Left",
        pattern: Pattern(data: [BOTTOM, LEFT])
    ),
    Preset(
        name: "Bottom Right",
        pattern: Pattern(data: [BOTTOM, RIGHT])
    ),
    Preset(
        name: "Left Top",
        pattern: Pattern(data: [LEFT, TOP])
    ),
    Preset(
        name: "Left Bottom",
        pattern: Pattern(data: [LEFT, BOTTOM])
    ),
    Preset(
        name: "Right Top",
        pattern: Pattern(data: [RIGHT, TOP])
    ),
    Preset(
        name: "Right Bottom",
        pattern: Pattern(data: [RIGHT, BOTTOM])
    )
]
