//
//  DuplicatedEntityService.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/12/23.
//

import Foundation
import CoreData
import Combine
import OSLog

class DuplicatedEntityService {
    private var disposables = Set<AnyCancellable>()
    private let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }

    public func start() {
        NotificationCenter.default
            .publisher(for: NSPersistentCloudKitContainer.eventChangedNotification)
            .sink(receiveValue: { notification in
                guard let cloudEvent = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else {
                    return
                }
                if cloudEvent.endDate == nil || !cloudEvent.succeeded {
                    // if it is a start or not succeeded, early return
                    return
                }
                switch cloudEvent.type {
                case .setup:
                    self.removeDuplicatedEntities()
                case .import:
                    self.removeDuplicatedEntities()
                default:
                    break
                }
            })
            .store(in: &disposables)
        removeDuplicatedEntities()
    }

    public func removeDuplicatedEntities() {
        self.removeDuplicatedGestures()
    }
    private func removeDuplicatedGestures() {
        let request = GestureEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(GestureEntity.createdAt), ascending: true)]
        guard let gestureEntities = try? self.viewContext.fetch(request) as [GestureEntity] else {
            return
        }
        var dict: [Int: Bool] = [:]
        var entitiesToRemove = Set<GestureEntity>()
        for entity in gestureEntities {
            let gesture: Gesture? = entity.gesture
            guard let gesture = gesture else {
                continue
            }
            let hash = gesture.contentHash
            if dict[hash] == nil {
                // first time seeing this gesture
                dict[gesture.contentHash] = true
                continue
            }
            if InitialDataService.initialGestureHashs.contains(hash) {
                // already has this gesture. Remove
                entitiesToRemove.insert(entity)
            }
        }
        print("Found \(entitiesToRemove.count) duplicated initial gestures")
        for entity in entitiesToRemove {
            self.viewContext.delete(entity)
        }
        try? self.viewContext.save()
    }
}
