//
//  EditGestureView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/07.
//

import SwiftUI

struct EditGestureView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss

    var gestureEntity: GestureEntity

    // local copies of values that can be modified in this view
    @State
    private var enabled: Bool = false
    @State
    private var pattern: Pattern = Pattern(data: [Vector.Bottom]) // setting a vector as empty array will show an error

    @State
    private var confirmationVisible = false

    var body: some View {
        if let gesture = self.gestureEntity.gesture {
            Form {
                Section {
                    Toggle("Enabled", isOn: $enabled.onChange {
                        self.updateGestureEntity(
                            g: self.gestureEntity,
                            updatedGesture: gesture.change(
                                path: \.enabled,
                                to: $0
                            )
                        )
                    }).onAppear {
                        self.enabled = gesture.enabled
                    }
                }
                Section("Pattern") {
                    HStack {
                        Spacer()
                        GeometryReader { proxy in
                            PatternPreview(frame: proxy.frame(in: .local), pattern: pattern).onAppear {
                                self.pattern = gesture.pattern
                            }
                        }
                        .frame(width: 180, height: 180)
                        .fixedSize()
                        .clipped()
                        Spacer()
                    }
                    Button("Select a New Pattern") {
                        // TODO
                    }
                }
                Section("Action") {
                    NavigationLinkView {
                        Text(gesture.action.title)
                    }
                }
                Section {
                    Button("Delete Gesture") {
                        self.confirmationVisible = true
                    }.foregroundColor(.red).confirmationDialog(
                        "Are you sure you want to delete this gesture? This cannot be undone.",
                        isPresented: $confirmationVisible,
                        titleVisibility: .visible
                    ) {
                        Button("Delete this gesture", role: .destructive) {
                            self.viewContext.delete(self.gestureEntity)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Edit Gesture")
            .onAppear {

            }
        }
    }

    func updateGestureEntity(g: GestureEntity, updatedGesture: Gesture) {
        self.viewContext.performAndWait {
            g.gesture = updatedGesture
            try? self.viewContext.save()
        }
    }
}

// TODO: Add preview
