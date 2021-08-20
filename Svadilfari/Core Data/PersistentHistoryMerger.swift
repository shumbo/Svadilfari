//
//  PersistentHistoryMerger.swift
//  PersistentHistoryMerger
//
//  Created by Shun Kashiwa on 2021/08/20.
//

import Foundation
import CoreData
import os

struct PersistentHistoryMerger {

    let backgroundContext: NSManagedObjectContext
    let viewContext: NSManagedObjectContext
    let currentTarget: AppTarget
    let userDefaults: UserDefaults

    func merge() throws {
        let fromDate = userDefaults.lastHistoryTransactionTimestamp(for: currentTarget) ?? .distantPast
        let fetcher = PersistentHistoryFetcher(context: backgroundContext, fromDate: fromDate)
        let history = try fetcher.fetch()

        guard !history.isEmpty else {
            Logger.coreData.info("No history transactions found to merge for target \(currentTarget, privacy: .public)")
            return
        }

        for h in history {
            Logger.coreData.info("History: \(h)")
        }

        Logger.coreData.info("Merging \(history.count) persistent history transactions for target \(currentTarget, privacy: .public)")

        history.merge(into: backgroundContext)

        viewContext.perform {
            history.merge(into: self.viewContext)
        }

        guard let lastTimestamp = history.last?.timestamp else { return }
        userDefaults.updateLastHistoryTransactionTimestamp(for: currentTarget, to: lastTimestamp)
    }
}

extension Collection where Element == NSPersistentHistoryTransaction {
    /// Merges the current collection of history transactions into the given managed object context.
    /// - Parameter context: The managed object context in which the history transactions should be merged.
    func merge(into context: NSManagedObjectContext) {
        forEach { transaction in
            guard let userInfo = transaction.objectIDNotification().userInfo else { return }
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: userInfo, into: [context])
        }
    }
}
