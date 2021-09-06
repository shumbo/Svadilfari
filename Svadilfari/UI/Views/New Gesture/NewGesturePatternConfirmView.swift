//
//  NewGesturePatternConfirm.swift
//  NewGesturePatternConfirm
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import SwiftUI

struct NewGesturePatternConfirmView: View {
    var pattern: Pattern
    @State private var showingNextView = false

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
                        showingNextView = true
                    },
                    label: {
                        Text("COMMON_CONTINUE").bold().frame(maxWidth: .infinity)
                    }
                ).buttonBorderShape(.roundedRectangle)
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .listRowInsets(EdgeInsets())
            }
            // Navigation
            NavigationLink(
                isActive: self.$showingNextView,
                destination: { NewGestureSelectActionView(pattern: pattern) },
                label: { EmptyView() }
            )
        }.navigationTitle("PREVIEW_PATTERN_TITLE")
    }
}

struct NewGesturePatternConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewGesturePatternConfirmView(
                pattern: Pattern(
                    data: [Vector(x: 100.0, y: 0.0), Vector(x: 0.0, y: 100.0)]
                )
            )
        }
    }
}
