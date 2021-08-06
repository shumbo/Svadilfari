//
//  NewGesturePatternConfirm.swift
//  NewGesturePatternConfirm
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import SwiftUI

struct NewGesturePatternConfirmView: View {
    let pattern: Pattern
    @State private var fingerCount = 1
    @State private var showingNextView = false

    var body: some View {
        ZStack {
            Form {
                Section("Pattern") {
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
                Section(
                    header: Text("Additional Settings"),
                    footer: Text("Specify how many fingers you want to draw the gesture with")
                ) {
                    HStack {
                        Stepper(value: $fingerCount, in: 1...3) {
                            HStack {
                                Text("Fingers")
                                Text("\(fingerCount)").foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                    }
                }
                Button(
                    action: {
                        showingNextView = true
                    },
                    label: {
                        Text("Continue").bold().frame(maxWidth: .infinity)
                    }
                ).buttonBorderShape(.roundedRectangle)
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .listRowInsets(EdgeInsets())
            }
            // Navigation
            NavigationLink(
                isActive: self.$showingNextView,
                destination: { NewGestureSelectActionView(pattern: self.pattern, fingers: self.fingerCount) },
                label: { EmptyView() }
            )
        }.navigationTitle("Pattern")
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
