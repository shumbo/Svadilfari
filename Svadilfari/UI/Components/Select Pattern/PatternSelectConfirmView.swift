//
//  PatternSelectConfirmView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/16.
//

import SwiftUI

struct PatternSelectConfirmView<Content: View>: View {
    var pattern: Pattern
    var onSelect: (Pattern) -> Void
    var content: () -> Content

    var body: some View {
        ZStack {
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
            }
            content()
        }.navigationTitle("PREVIEW_PATTERN_TITLE")
    }
}

struct PatternSelectConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        PatternSelectConfirmView(
            pattern: Pattern(
                data: [Vector(x: 100.0, y: 0.0), Vector(x: 0.0, y: 100.0)]
            ),
            onSelect: { _ in
                // noop
            },
            content: { EmptyView() }
        )
    }
}
