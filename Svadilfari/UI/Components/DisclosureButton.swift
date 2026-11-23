//
//  DisclosureButton.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import SwiftUI

/// A list row button that shows a disclosure chevron like a `NavigationLink` row.
struct DisclosureButton<Label: View>: View {
    let action: () -> Void
    @ViewBuilder let label: Label

    var body: some View {
        Button(action: action) {
            HStack {
                label
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
            .contentShape(.rect)
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    NavigationStack {
        List {
            DisclosureButton(action: {}) {
                Text("This adds arrow to any view")
            }
            NavigationLink("Navigation link for comparison") {
                EmptyView()
            }
        }.navigationTitle("Some List")
    }
}
