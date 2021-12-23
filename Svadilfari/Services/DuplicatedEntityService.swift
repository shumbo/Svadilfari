//
//  DuplicatedEntityService.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/12/23.
//

import Foundation
import CoreData
import Combine

class DuplicatedEntityService {
    private var disposables = Set<AnyCancellable>()
    private let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext

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
            // have seen the same gesture in previous iteration
            entitiesToRemove.insert(entity)
        }
        for entity in entitiesToRemove {
            self.viewContext.delete(entity)
        }
    }
}
