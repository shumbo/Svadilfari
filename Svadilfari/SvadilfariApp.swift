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
    var persistentContainer: NSPersistentContainer {
        print("compute")

        let container = PersistenceController.shared.container
        container.viewContext.name = "view_context"
        container.viewContext.transactionAuthor = "main_app"

        let persistentHistoryObserver = PersistentHistoryObserver(
            target: .app,
            persistentContainer: container,
            userDefaults: UserDefaults.shared
        )
        persistentHistoryObserver.startObserving()

        return container
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
