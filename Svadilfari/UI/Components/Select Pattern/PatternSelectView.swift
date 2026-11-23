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
struct PatternSelectView: View {
    private enum Step: Hashable {
        case presets, draw, confirm
    }

    @Environment(\.dismiss) var dismiss

    @Binding var path: NavigationPath
    var onSelect: (Pattern) -> Void

    @State private var candidate: Pattern?

    var body: some View {
        List {
            Section {
                GestureTemplateButton(
                    image: Image(systemName: "list.dash"),
                    text: "NEW_GESTURE_SELECT_PATTERN",
                    color: .blue,
                    buttonTitle: "NEW_GESTURE_SELECT_PATTERN_BUTTON",
                    onPress: {
                        path.append(Step.presets)
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
                        path.append(Step.draw)
                    }
                )
            }
        }
        .navigationDestination(for: Step.self) { step in
            switch step {
            case .presets:
                PatternSelectPresetsView(onPick: self.confirm)
            case .draw:
                PatternSelectDrawerView(onDraw: self.confirm)
            case .confirm:
                if let candidate {
                    PatternSelectConfirmView(pattern: candidate, onSelect: self.onSelect)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("COMMON_CANCEL") {
                    self.dismiss()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .interactiveDismissDisabled(!path.isEmpty)
    }

    private func confirm(_ pattern: Pattern) {
        candidate = pattern
        path.append(Step.confirm)
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    NavigationStack(path: $path) {
        PatternSelectView(path: $path, onSelect: { _ in
            print("Pattern Selected")
        })
    }
}
