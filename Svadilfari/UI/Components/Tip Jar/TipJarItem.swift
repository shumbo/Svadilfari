//
//  TipJarItem.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2022/07/24.
//

import SwiftUI
import StoreKit

struct TipJarItem: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var displayName: String
    var displayPrice: String
    var loading: Bool
    var onPurchase: () -> Void
    var body: some View {
        HStack {
            Text(displayName)
            Spacer()
            Button(action: onPurchase) {
                ZStack {
                    Text(displayPrice)
                        .bold()
                        .opacity(loading ? 0 : 1)
                    ProgressView()
                        .opacity(loading ? 1 : 0)
                }
            }
            .disabled(loading)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.systemGray5))
                .cornerRadius(.infinity)
        }
    }
}

struct TipJarItem_Previews: PreviewProvider {
    @State static var loading = false
    static var previews: some View {
        Group {
            TipJarItem(displayName: "Small Tip", displayPrice: "$0.99", loading: false, onPurchase: {
            })
            .preferredColorScheme(.light)
            TipJarItem(displayName: "Small Tip", displayPrice: "$0.99", loading: true, onPurchase: {
            })
            .preferredColorScheme(.light)
            TipJarItem(displayName: "Small Tip", displayPrice: "$0.99", loading: false, onPurchase: {
            })
            .preferredColorScheme(.dark)
            TipJarItem(displayName: "Small Tip", displayPrice: "$0.99", loading: true, onPurchase: {
            })
            .preferredColorScheme(.dark)
        }
    }
}
