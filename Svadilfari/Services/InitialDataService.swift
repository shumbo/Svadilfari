//
//  InitialDataService.swift
//  InitialDataService
//
//  Created by Shun Kashiwa on 2021/09/01.
//

import Foundation
import UIKit
import CoreData

class InitialDataService {
    static var shared = InitialDataService(
        userDefaults: UserDefaults.shared,
        moc: PersistenceController.shared.container.viewContext
    )

    private let userDefaults: UserDefaults
    private let moc: NSManagedObjectContext

    private var _isFirstLaunch = false

    /// true if the app is launched for the first time
    public var isFirstLaunch: Bool {
        return self._isFirstLaunch
    }

    init(userDefaults: UserDefaults, moc: NSManagedObjectContext) {
        self.userDefaults = userDefaults
        self.moc = moc
    }

    public func exec() {
        // copy the value
        self._isFirstLaunch = userDefaults.isFirstLaunch
        // write it to false
        userDefaults.isFirstLaunch = false

        if _isFirstLaunch {
            self.registerInitialGestures()
        }
    }

    private func registerInitialGestures() {
        for (action, pattern) in initialGestureData.reversed() {
            let id = UUID()
            let g = Gesture(
                action: action,
                enabled: true,
                id: id.uuidString,
                pattern: pattern
            )
            let e = GestureEntity(context: self.moc)
            e.json = try? g.jsonString()
            e.createdAt = Date()
            e.updatedAt = Date()
            e.id = id
        }
        try? self.moc.save()
    }
}

private let initialGestureData: [(Action, Pattern)] = [
    (Action(tabPrevious: true), Pattern(data: [Vector.Top, Vector.Left])),
    (Action(tabNext: true), Pattern(data: [Vector.Top, Vector.Right])),
    (Action(tabClose: true), Pattern(data: [Vector.Bottom, Vector.Right])),
    (Action(tabCloseAll: true), Pattern(data: [Vector.Bottom, Vector.Right, Vector.Top])),
    (Action(tabOpen: true), Pattern(data: [Vector.Bottom, Vector.Left])),
    (Action(tabDuplicate: true), Pattern(data: [Vector.Bottom, Vector.Left, Vector.Top]))
]
