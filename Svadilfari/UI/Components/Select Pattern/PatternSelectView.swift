//
//  PatternSelectView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

/**
 Create a new pattern
 Users choose if they want to 1) select a pattern from presets or 2) draw a pattern of their choice
 Receive a created pattern from `onSelect` callback
 */
struct PatternSelectView<Content: View>: View {
    @Environment(\.dismiss) var dismiss

    let content: () -> Content
    var onSelect: (Pattern) -> Void

    init(onSelect: @escaping (Pattern) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.onSelect = onSelect
        self.content = content
    }

    @State private var showingNewPatternPresets = false
    @State private var showingNewPatternDraw = false

    var body: some View {
        VStack {
            NavigationLink(
                destination: PatternSelectPresetsView(onSelect: self.onSelect, content: self.content),
                isActive: $showingNewPatternPresets
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: PatternSelectDrawerView(onSelect: self.onSelect, content: self.content),
                isActive: $showingNewPatternDraw
            ) {
                EmptyView()
            }
            List {
                Section {
                    GestureTemplateButton(
                        image: Image(systemName: "list.dash"),
                        text: "NEW_GESTURE_SELECT_PATTERN",
                        color: .blue,
                        buttonTitle: "NEW_GESTURE_SELECT_PATTERN_BUTTON",
                        onPress: {
                            showingNewPatternPresets = true
                        }
                    )
                }
                Section {
                    GestureTemplateButton(
                        image: Image(systemName: "hand.draw"),
                        text: "NEW_GESTURE_DRAW_PATTERN",
                        color: .green,
                        buttonTitle: "NEW_GESTURE_DRAW_PATTERN_BUTTON",
                        onPress: {
                            showingNewPatternDraw = true
                        }
                    )
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("COMMON_CANCEL") {
                    self.dismiss()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        // disable interactive dismiss if one of the two is active
        .interactiveDismissDisabled(self.showingNewPatternPresets || self.showingNewPatternDraw)
    }
}

extension PatternSelectView where Content == EmptyView {
    init(onSelect: @escaping (Pattern) -> Void) {
        self.init(onSelect: onSelect, content: { EmptyView() })
    }
}

struct PatternSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PatternSelectView(onSelect: { _ in
            print("Pattern Selected")
        }) {
            EmptyView()
        }
    }
}
