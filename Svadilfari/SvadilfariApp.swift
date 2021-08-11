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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
