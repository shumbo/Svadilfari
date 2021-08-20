//
//  PersistentHistoryCleaner.swift
//  PersistentHistoryCleaner
//
//  Created by Shun Kashiwa on 2021/08/20.
//

import Foundation
import CoreData
import os

struct PersistentHistoryCleaner {

    let context: NSManagedObjectContext
    let targets: [AppTarget]
    let userDefaults: UserDefaults

    /// Cleans up the persistent history by deleting the transactions that have been merged into each target.
    func clean() throws {
        guard let timestamp = userDefaults.lastCommonTransactionTimestamp(in: targets) else {
            Logger.coreData.debug("Cancelling deletions as there is no common transaction timestamp")
            return
        }

        let deleteHistoryRequest = NSPersistentHistoryChangeRequest.deleteHistory(before: timestamp)
        Logger.coreData.debug("Deleting persistent history using common timestamp \(timestamp)")
        try context.execute(deleteHistoryRequest)

        targets.forEach { target in
            /// Reset the dates as we would otherwise end up in an infinite loop.
            userDefaults.updateLastHistoryTransactionTimestamp(for: target, to: nil)
        }
    }
}
