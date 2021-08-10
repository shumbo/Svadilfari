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
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyApplication")
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
        return container
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
