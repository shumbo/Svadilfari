//
//  PersistentHistoryTracking.swift
//  PersistentHistoryTracking
//
//  Created by Shun Kashiwa on 2021/08/20.
//

import Foundation
import CoreData
import os
import Combine

public enum AppTarget: String, CaseIterable {
    case app
    case safariExtension
}

extension AppTarget: CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}

public final class PersistentHistoryObserver {

    private var subscriptions: Set<AnyCancellable> = []

    private let target: AppTarget
    private let userDefaults: UserDefaults
    private let persistentContainer: NSPersistentContainer

    /// An operation queue for processing history transactions.
    private lazy var historyQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    public init(target: AppTarget, persistentContainer: NSPersistentContainer, userDefaults: UserDefaults) {
        self.target = target
        self.userDefaults = userDefaults
        self.persistentContainer = persistentContainer
    }

    public func startObserving() {
        NotificationCenter.default
             .publisher(for: .NSPersistentStoreRemoteChange)
             .sink {
                 print($0)
                 self.processPersistentHistory()
             }
             .store(in: &subscriptions)
    }

    /// Process persistent history to merge changes from other coordinators.
    @objc private func processStoreRemoteChanges(_ notification: Notification) {
        Logger.coreData.info("Notification Received: \(notification)")
        historyQueue.addOperation { [weak self] in
            self?.processPersistentHistory()
        }
    }

    @objc private func processPersistentHistory() {
        let context = persistentContainer.newBackgroundContext()
        context.performAndWait {
            do {
                let merger = PersistentHistoryMerger(
                    backgroundContext: context,
                    viewContext: persistentContainer.viewContext,
                    currentTarget: target,
                    userDefaults: userDefaults
                )
                try merger.merge()

                let cleaner = PersistentHistoryCleaner(
                    context: context,
                    targets: AppTarget.allCases,
                    userDefaults: userDefaults
                )
                try cleaner.clean()
            } catch {
                print("Persistent History Tracking failed with error \(error)")
            }
        }
    }
}
