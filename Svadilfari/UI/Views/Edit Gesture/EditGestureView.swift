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

    @State
    private var patternSelectorVisible = false

    @State
    private var actionSelectorVisible = false

    @State
    private var actionConfigVisible = false

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
                        self.patternSelectorVisible = true
                    }.sheet(isPresented: $patternSelectorVisible, onDismiss: { patternSelectorVisible = false }) {
                        NavigationView {
                            PatternSelectView(onSelect: {pattern in
                                // edit local copy
                                self.pattern = pattern
                                self.updateGestureEntity(
                                    g: self.gestureEntity,
                                    updatedGesture: gesture.change(
                                        path: \.pattern, to: pattern
                                    )
                                )
                                self.patternSelectorVisible = false
                            })
                            .navigationTitle("New Pattern")
                        }
                    }
                }
                Section("Action") {
                    if gesture.action.hasAdditionalConfig {
                        NavigationLinkView {
                            Text(gesture.action.title)
                        }.background {
                            NavigationLink(isActive: $actionConfigVisible, destination: {
                                ActionConfigView(action: gesture.action) { newAction in
                                    self.updateGestureEntity(
                                        g: self.gestureEntity,
                                        updatedGesture: gesture.change(
                                            path: \.action, to: newAction
                                        )
                                    )
                                    self.actionConfigVisible = false
                                }
                            }, label: { EmptyView() })
                        }.onTapGesture {
                            actionConfigVisible = true
                        }
                    } else {
                        Text(gesture.action.title)
                    }
                    Button("Select a New Action") {
                        self.actionSelectorVisible = true
                    }.sheet(
                        isPresented: $actionSelectorVisible,
                        onDismiss: { self.actionSelectorVisible = false }
                    ) {
                        NavigationView {
                            ActionSelectView(onSelect: { newAction in
                                self.updateGestureEntity(
                                    g: self.gestureEntity,
                                    updatedGesture: gesture.change(
                                        path: \.action, to: newAction
                                    )
                                )
                                self.actionSelectorVisible = false
                            }).navigationTitle("New Action")
                        }
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
            .navigationTitle(gesture.action.title)
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
