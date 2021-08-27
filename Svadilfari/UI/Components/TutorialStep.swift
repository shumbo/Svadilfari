//
//  TutorialStep.swift
//  TutorialStep
//
//  Created by Shun Kashiwa on 2021/08/27.
//

import SwiftUI

struct TutorialStep: View {
    var text: LocalizedStringKey
    var image: Image
    var color: Color?

    var body: some View {
        HStack {
            image.resizable()
                .foregroundColor(color)
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .cornerRadius(4)
            Text(text).lineLimit(nil)
        }
    }
}

struct TutorialStep_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TutorialStep(
                text: "Open the Settings App",
                image: Image(systemName: "gearshape"),
                color: .secondary
            )
            TutorialStep(
                text: "Open the Settings App Open the Settings App Open the Settings App Open the Settings App",
                image: Image(systemName: "gearshape"),
                color: .secondary
            )
        }
    }
}
