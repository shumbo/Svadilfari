//
//  NewGestureView.swift
//  NewGestureView
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import SwiftUI

struct NewGestureView: View {
    @Environment(\.dismiss) var dismiss

    @State private var showingNewGesturePresets = false
    @State private var updater: Bool = false

    var body: some View {
        VStack {
            NavigationLink(destination: NewGesturePresetsView(), isActive: $showingNewGesturePresets) { EmptyView() }
            List {
                Section {
                    GestureTemplateButton(
                        image: Image(systemName: "list.dash"),
                        text: "Select a pattern from presets",
                        color: .blue,
                        buttonTitle: "Select Pattern",
                        onPress: {
                            showingNewGesturePresets = true
                        }
                    )
                }
                Section {
                    GestureTemplateButton(
                        image: Image(systemName: "hand.draw"),
                        text: "Draw gesture of your choice",
                        color: .green,
                        buttonTitle: "Draw Pattern",
                        onPress: {
                            // TODO
                        }
                    )
                }
            }
        }.navigationTitle("New Gesture")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                Button("Cancel", action: self.dismiss.callAsFunction)
            )
            .interactiveDismissDisabled()
    }
}

struct NewGestureView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView().sheet(isPresented: .constant(true), content: {
            NavigationView {
                NewGestureView()
            }}
        )
    }
}
