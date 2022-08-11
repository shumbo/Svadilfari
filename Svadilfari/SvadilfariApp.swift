//
//  SvadilfariApp.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI
import CoreData

@main
struct SvadilfariApp: App {
    let persistentContainer: NSPersistentContainer
    let duplicatedEntityService: DuplicatedEntityService
    init() {
        let container: NSPersistentContainer = PersistenceController.shared.container
        container.viewContext.name = "view_context"
        container.viewContext.transactionAuthor = "main_app"

        container.viewContext.automaticallyMergesChangesFromParent = true
        try? container.viewContext.setQueryGenerationFrom(.current)

        if ProcessInfo.processInfo.arguments.contains("DISABLE_ANIMATION") {
            UIView.setAnimationsEnabled(false)
        }

        let persistentHistoryObserver = PersistentHistoryObserver(
            target: .app,
            persistentContainer: container,
            userDefaults: UserDefaults.shared
        )
        persistentHistoryObserver.startObserving()

        InitialDataService.shared.exec()

        self.persistentContainer = container
        self.duplicatedEntityService = DuplicatedEntityService(viewContext: container.viewContext)
        print("launch")
        self.duplicatedEntityService.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
