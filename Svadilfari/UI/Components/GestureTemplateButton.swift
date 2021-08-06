//
//  GestureTemplateButton.swift
//  GestureTemplateButton
//
//  Created by Shun Kashiwa on 2021/08/04.
//

import SwiftUI

struct GestureTemplateButton: View {
    let image: Image
    let text: String
    let color: Color
    let buttonTitle: String
    let onPress: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            self.image
                .resizable()
                .frame(width: 44, height: 44, alignment: .center)
                .foregroundColor(self.color)
            Text(self.text)
                .multilineTextAlignment(.center)
            Button(
                action: self.onPress,
                label: {
                    Text(self.buttonTitle).bold().frame(maxWidth: .infinity)
                }
            ).buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .tint(self.color)
        }.listRowInsets(EdgeInsets(top: 16, leading: 8, bottom: 8, trailing: 8))
    }
}

struct GestureTemplateButton_Previews: PreviewProvider {
    static var previews: some View {
        List {
            GestureTemplateButton(
                image: Image(systemName: "list.dash"),
                text: "Select a gesture from presets and assign an action of your choice.",
                color: .orange,
                buttonTitle: "Select Gesture from List",
                onPress: {
                    print("hello")
                }
            )
        }
    }
}
