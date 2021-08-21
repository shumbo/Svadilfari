//
//  PersistentHistoryFetcher.swift
//  PersistentHistoryFetcher
//
//  Created by Shun Kashiwa on 2021/08/20.
//

import Foundation
import CoreData
import os

struct PersistentHistoryFetcher {
    enum Error: Swift.Error {
        /// In case that the fetched history transactions couldn't be converted into the expected type.
        case historyTransactionConversionFailed
    }

    let context: NSManagedObjectContext
    let fromDate: Date

    func fetch() throws -> [NSPersistentHistoryTransaction] {
        let fetchRequest = createFetchRequest()
        guard let historyResult = try context.execute(fetchRequest) as? NSPersistentHistoryResult,
              let history = historyResult.result as? [NSPersistentHistoryTransaction] else {
            throw Error.historyTransactionConversionFailed
        }
        return history
    }

    func createFetchRequest() -> NSPersistentHistoryChangeRequest {
        let historyFetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: fromDate)
        if let fetchRequest = NSPersistentHistoryTransaction.fetchRequest {
            var predicates: [NSPredicate] = []
            // swiftlint:disable line_length
            Logger.coreData.info(
                "Current context author \(context.transactionAuthor ?? "(not set)", privacy: .public) name \(context.name ?? "(not set)", privacy: .public)"
            )
            // swiftlint:enable line_length
            if let transactionAuthor = context.transactionAuthor {
                predicates.append(
                    NSPredicate(format: "%K != %@", #keyPath(NSPersistentHistoryTransaction.author), transactionAuthor)
                )
            }
            if let contextName = context.name {
                predicates.append(
                    NSPredicate(format: "%K != %@", #keyPath(NSPersistentHistoryTransaction.contextName), contextName)
                )
            }
            fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
            historyFetchRequest.fetchRequest = fetchRequest
        }
        return historyFetchRequest
    }
}
