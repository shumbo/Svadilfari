//
//  TutorialView.swift
//  TutorialView
//
//  Created by Shun Kashiwa on 2021/08/27.
//

import SwiftUI

// swiftlint:disable:next identifier_name
private let SLIDE_MAX_WIDTH: CGFloat = 480.0

struct TutorialView: View {
    @Environment(\.presentationMode) var presentation
    @State private var page = 1

    var onOpenGestures: () -> Void

    var body: some View {
        TabView(selection: $page) {
            VStack(alignment: .center, spacing: 16) {
                Image("Icon")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(21)
                Text("TUTORIAL_WELCOME_TITLE")
                    .font(.title).bold()
                Text("TUTORIAL_WELCOME_MESSAGE")
                    .font(.body).multilineTextAlignment(.center)
                Button(action: {
                    page += 1
                }, label: {
                    Text("COMMON_CONTINUE").frame(maxWidth: .infinity).frame(height: 32)
                })
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 16)
            }.padding(.all, 24).frame(maxWidth: SLIDE_MAX_WIDTH).tag(1)
            VStack(alignment: .center, spacing: 32) {
                Text("TUTORIAL_OPEN_EXT_TITLE").font(.title).bold()
                TutorialStepList {
                    TutorialStep(
                        text: "TUTORIAL_OPEN_EXT_SETTINGS",
                        image: Image(systemName: "gearshape"),
                        color: .secondary
                    )
                    TutorialStep(
                        text: "TUTORIAL_OPEN_EXT_SAFARI",
                        image: Image(systemName: "safari"),
                        color: .cyan
                    )
                    TutorialStep(
                        text: "TUTORIAL_OPEN_EXT_EXTENSIONS",
                        image: Image(systemName: "puzzlepiece.extension"),
                        color: .orange
                    )
                    TutorialStep(
                        text: "TUTORIAL_OPEN_EXT_SVADILFARI",
                        image: Image(uiImage: Bundle.main.icon ?? UIImage()),
                        color: nil
                    )
                }
                Button(action: {
                    page += 1
                }, label: {
                    Text("COMMON_CONTINUE").frame(maxWidth: .infinity).frame(height: 32)
                })
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 16)
            }.padding(.all, 24).frame(maxWidth: SLIDE_MAX_WIDTH).tag(2)
            VStack(alignment: .center, spacing: 32) {
                Text("TUTORIAL_ENABLE_EXT_TITLE").font(.title).bold()
                VStack(spacing: 16) {
                    TutorialStepList {
                        TutorialStep(
                            text: "TUTORIAL_ENABLE_EXT_ENABLE",
                            image: Image(systemName: "checkmark.circle"),
                            color: .green
                        )
                        TutorialStep(
                            text: "TUTORIAL_ENABLE_EXT_ALL_WEBSITES",
                            image: Image(systemName: "hammer"),
                            color: .cyan
                        ).fixedSize(horizontal: false, vertical: true)
                        TutorialStep(
                            text: "TUTORIAL_ENABLE_EXT_ALL_ALLOW",
                            image: Image(systemName: "hand.tap"),
                            color: .indigo
                        ).fixedSize(horizontal: false, vertical: true)
                    }
                }
                Text("TUTORIAL_ENABLE_EXT_FOOTNOTE")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button(action: {
                    page += 1
                }, label: {
                    Text("COMMON_CONTINUE").frame(maxWidth: .infinity).frame(height: 32)
                })
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
            }.padding(.all, 24).frame(maxWidth: SLIDE_MAX_WIDTH).tag(3)
            VStack(alignment: .center, spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundColor(Color.green)
                Text("TUTORIAL_DONE_TITLE").font(.title).bold()
                Text("TUTORIAL_DONE_MESSAGE")
                    .font(.body).multilineTextAlignment(.center)
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                    self.onOpenGestures()
                }, label: {
                    Text("TUTORIAL_DONE_VIEW_GESTURES").frame(maxWidth: .infinity).frame(height: 32)
                })
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 16)
                Link("TUTORIAL_DONE_OPEN_CHECKER", destination: URL(string: "https://rebrand.ly/svadilfari-check")!)
            }.padding(.all, 24).frame(maxWidth: SLIDE_MAX_WIDTH).tag(4)
        }.tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .transition(.slide)
            .animation(.easeInOut, value: page)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(onOpenGestures: {
            // noop
        })
    }
}
