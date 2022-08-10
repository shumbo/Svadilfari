//
//  Store.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2022/07/24.
//

import Foundation
import StoreKit

public enum IAPStoreError: Error {
    case failedVerification
}

class IAPStore: ObservableObject {
    @Published private(set) var tips: [Product]
    @Published var tippingAppreciationPresented = false

    var updateListenerTask: Task<Void, Error>?

    init() {
        self.tips = []
        self.updateListenerTask = listenForTransactions()
        Task {
            await self.requestProducts()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            // Iterate through any transactions that don't come from a direct call to `purchase()`.
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)

                    // if tip is purchased
                    if IAP_TIP_IDENTIFIERS.contains(transaction.productID) {
                        await self.displayThanksAlert()
                    }

                    // Always finish a transaction.
                    await transaction.finish()
                } catch {
                    // StoreKit has a transaction that fails verification. Don't deliver content to the user.
                    print("Transaction failed verification")
                }
            }
        }
    }

    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: IAP_TIP_IDENTIFIERS)
            var newTips: [Product] = []

            for product in storeProducts {
                if product.type != .consumable {
                    continue
                }
                newTips.append(product)
            }
            self.tips = newTips.sorted(by: { return $0.price < $1.price })
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }

    @MainActor
    func displayThanksAlert() async {
        self.tippingAppreciationPresented = true
    }

    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            await displayThanksAlert()
            await transaction.finish()
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }

    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        // Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            // StoreKit parses the JWS, but it fails verification.
            throw IAPStoreError.failedVerification
        case .verified(let safe):
            // The result is verified. Return the unwrapped value.
            return safe
        }
    }
}
