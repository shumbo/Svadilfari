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
                    Toggle("GESTURE_EDIT_ENABLED", isOn: $enabled.onChange {
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
                Section(header: Text("GESTURE_EDIT_PATTERN")) {
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
                    Button("GESTURE_EDIT_NEW_PATTERN_SELECT") {
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
                            .navigationTitle("GESTURE_EDIT_NEW_PATTERN_NAV_TITLE")
                        }
                    }
                }
                Section(header: Text("GESTURE_EDIT_ACTION")) {
                    if gesture.action.hasAdditionalConfig {
                        NavigationLinkView {
                            Text(gesture.action.title)
                        }.onTapGesture {
                            self.actionConfigVisible = true
                        }.sheet(
                            isPresented: $actionConfigVisible,
                            onDismiss: { actionConfigVisible = false }
                        ) {
                            NavigationView {
                                ActionConfigView(action: gesture.action) { newAction in
                                    self.updateGestureEntity(
                                        g: self.gestureEntity,
                                        updatedGesture: gesture.change(
                                            path: \.action, to: newAction
                                        )
                                    )
                                    self.actionConfigVisible = false
                                }.toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button("COMMON_CANCEL") {
                                            self.actionConfigVisible = false
                                        }
                                    }
                                }.navigationBarTitleDisplayMode(.inline)
                                .interactiveDismissDisabled()
                            }
                        }
                    } else {
                        Text(gesture.action.title)
                    }
                    Button("GESTURE_EDIT_NEW_ACTION_SELECT") {
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
                            }).navigationTitle("GESTURE_EDIT_NEW_ACTION_NAV_TITLE")
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button("COMMON_CANCEL") {
                                            self.actionSelectorVisible = false
                                        }
                                    }
                                }
                                .navigationBarTitleDisplayMode(.inline)
                                .interactiveDismissDisabled()
                        }
                    }
                }
                Section {
                    Button("GESTURE_EDIT_DELETE") {
                        self.confirmationVisible = true
                    }.foregroundColor(.red).confirmationDialog(
                        "GESTURE_EDIT_DELETE_CONFIRM_TITLE",
                        isPresented: $confirmationVisible
                    ) {
                        Button("GESTURE_EDIT_DELETE_CONFIRM_BUTTON", role: .destructive) {
                            self.viewContext.delete(self.gestureEntity)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle(gesture.action.shortTitle)
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
