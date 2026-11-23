//
//  PatternSelectConfirmView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct PatternSelectConfirmView: View {
    var pattern: Pattern
    var onSelect: (Pattern) -> Void

    var body: some View {
        Form {
            Section(LocalizedStringKey("PREVIEW_PATTERN_SELECTED_PATTERN")) {
                HStack {
                    Spacer()
                    GeometryReader { proxy in
                        PatternPreview(frame: proxy.frame(in: .local), pattern: pattern)
                    }
                    .frame(width: 180, height: 180)
                    .fixedSize()
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .clipped()
                    Spacer()
                }
            }
            Button(
                action: {
                    self.onSelect(pattern)
                },
                label: {
                    Text("PREVIEW_PATTERN_USE").bold().frame(maxWidth: .infinity)
                }
            ).buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
        }.navigationTitle("PREVIEW_PATTERN_TITLE")
    }
}

#Preview {
    PatternSelectConfirmView(
        pattern: Pattern(
            data: [Vector(x: 100.0, y: 0.0), Vector(x: 0.0, y: 100.0)]
        ),
        onSelect: { _ in
            // noop
        }
    )
}
