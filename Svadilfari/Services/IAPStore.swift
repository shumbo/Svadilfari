//
//  Store.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2022/07/24.
//

import Foundation
import Observation
import StoreKit

public enum IAPStoreError: Error {
    case failedVerification
}

@MainActor
@Observable
final class IAPStore {
    private(set) var tips: [Product] = []
    var tippingAppreciationPresented = false

    @ObservationIgnored private var updateListenerTask: Task<Void, Never>?

    init() {
        updateListenerTask = Task { [weak self] in
            // Transactions that don't come from a direct call to `purchase()`.
            for await result in Transaction.updates {
                guard let transaction = try? Self.checkVerified(result) else { continue }
                if IAP_TIP_IDENTIFIERS.contains(transaction.productID) {
                    self?.tippingAppreciationPresented = true
                }
                await transaction.finish()
            }
        }
        Task {
            await requestProducts()
        }
    }

    isolated deinit {
        updateListenerTask?.cancel()
    }

    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: IAP_TIP_IDENTIFIERS)
            tips = storeProducts
                .filter { $0.type == .consumable }
                .sorted { $0.price < $1.price }
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }

    func purchase(_ product: Product) async throws -> Transaction? {
        switch try await product.purchase() {
        case .success(let verification):
            let transaction = try Self.checkVerified(verification)
            tippingAppreciationPresented = true
            await transaction.finish()
            return transaction
        default:
            return nil
        }
    }

    private nonisolated static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw IAPStoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}
