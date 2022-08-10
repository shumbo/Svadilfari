//
//  TipJarView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2022/07/24.
//

import SwiftUI
import StoreKit

struct TipJarView: View {
    @EnvironmentObject var store: IAPStore
    @State var productIdOnPurchase = ""

    var body: some View {
        List {
            Section(
                footer: Text("TIP_JAR_MESSAGE")
            ) {
                ForEach(store.tips) { tip in
                    TipJarItem(
                        displayName: tip.displayName,
                        displayPrice: tip.displayPrice,
                        loading: productIdOnPurchase == tip.id,
                        onPurchase: {
                            productIdOnPurchase = tip.id
                        Task {
                            await purchase(tip)
                            productIdOnPurchase = ""
                        }
                    })
                }
            }
        }
            .navigationTitle("TIP_JAR_TITLE")
            .navigationViewStyle(.stack).sheet(isPresented: $store.tippingAppreciationPresented, content: {
                TippingAppreciation(onContinue: {
                    store.tippingAppreciationPresented = false
                })
            })
    }

    func purchase(_ product: Product) async {
        do {
            if try await store.purchase(product) != nil {

            }
        } catch IAPStoreError.failedVerification {
            print("Failed verification for \(product.id)")
        } catch {
            print("Failed purchase for \(product.id): \(error)")
        }
    }
}
