//
//  TutorialStepList.swift
//  TutorialStepList
//
//  Created by Shun Kashiwa on 2021/08/27.
//

import SwiftUI

struct TutorialStepList<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            content
        }
    }
}

#Preview {
    TutorialStepList {
        Text("Item 1")
        Text("Item 2")
        Text("Item 3")
    }
}
