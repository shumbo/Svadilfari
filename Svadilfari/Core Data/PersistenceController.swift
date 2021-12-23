//
//  PersistenceController.swift
//  PersistenceController
//
//  Created by Shun Kashiwa on 2021/08/10.
//

import CoreData
import Combine

class PersistenceController {
    private var subscriptions: Set<AnyCancellable> = []

    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    var container: NSPersistentContainer!

    init(inMemory: Bool = false) {
        setupContainer(sync: UserDefaults.shared.icloudSyncEnabled, inMemory: inMemory)
    }

    private func setupContainer(sync: Bool = true, inMemory: Bool = false) {
        self.container = NSPersistentCloudKitContainer(name: "CoreData")

        // store the data in App Group
        let storeURL = URL.storeURL(for: APP_GROUP_ID, databaseName: "Svadilfari")

        let description = NSPersistentStoreDescription(url: storeURL)

        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        if sync {
            description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(
                containerIdentifier: "iCloud.app.svadilfari.svadilfari"
            )
        } else {
            description.cloudKitContainerOptions = nil
        }
        container.persistentStoreDescriptions = [description]

        // if inMemory is true, store it in memory
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        // load persistent stores
        self.container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        try? self.container.viewContext.setQueryGenerationFrom(.current)
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }

    private func setupDuplicateCollector() {

    }

    public func toggleSync(sync: Bool) {
        setupContainer(sync: sync, inMemory: false)
    }
}
