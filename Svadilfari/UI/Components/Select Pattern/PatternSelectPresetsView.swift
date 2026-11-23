//
//  PatternSelectPresetsView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct PatternSelectPresetsView: View {
    var onPick: (Pattern) -> Void

    var body: some View {
        List {
            ForEach(presets) { preset in
                DisclosureButton(action: { self.onPick(preset.pattern) }) {
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

#Preview {
    NavigationStack {
        PatternSelectPresetsView(onPick: { _ in
            // noop
        })
    }
}

private struct Preset: Identifiable {
    var id: UUID = UUID()
    let name: LocalizedStringKey
    let pattern: Pattern
}

// TODO: Replace those with Vector's static fields
private let UP = Vector(x: 0.0, y: -100.0)
private let LEFT = Vector(x: -100.0, y: 0.0)
private let RIGHT = Vector(x: 100.0, y: 0.0)
private let DOWN = Vector(x: 0.0, y: 100.0)

@MainActor private let presets: [Preset] = [
    Preset(
        name: "PATTERN_PRESET_UP_LEFT",
        pattern: Pattern(data: [UP, LEFT])
    ),
    Preset(
        name: "PATTERN_PRESET_UP_RIGHT",
        pattern: Pattern(data: [UP, RIGHT])
    ),
    Preset(
        name: "PATTERN_PRESET_DOWN_LEFT",
        pattern: Pattern(data: [DOWN, LEFT])
    ),
    Preset(
        name: "PATTERN_PRESET_DOWN_RIGHT",
        pattern: Pattern(data: [DOWN, RIGHT])
    ),
    Preset(
        name: "PATTERN_PRESET_LEFT_UP",
        pattern: Pattern(data: [LEFT, UP])
    ),
    Preset(
        name: "PATTERN_PRESET_LEFT_DOWN",
        pattern: Pattern(data: [LEFT, DOWN])
    ),
    Preset(
        name: "PATTERN_PRESET_RIGHT_UP",
        pattern: Pattern(data: [RIGHT, UP])
    ),
    Preset(
        name: "PATTERN_PRESET_RIGHT_DOWN",
        pattern: Pattern(data: [RIGHT, DOWN])
    )
]
