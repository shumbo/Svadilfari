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
        } else {
            print("Not first launch, skipping initial gesture registration")
        }
    }

    private func registerInitialGestures() {
        print("This is first launch, registering initial gestures")
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

    /// Set of hash of initial gestures. Used to determine duplicated initial gestures.
    static let initialGestureHashes: Set<Int> = {
        var s = Set<Int>()
        for (action, pattern) in initialGestureData {
            let g = Gesture(action: action, enabled: true, id: UUID().uuidString, pattern: pattern)
            s.insert(g.contentHash)
        }
        return s
    }()
}

private let initialGestureData: [(Action, Pattern)] = [
    (Action(tabPrevious: true), Pattern(data: [Vector.Top, Vector.Left])),
    (Action(tabNext: true), Pattern(data: [Vector.Top, Vector.Right])),
    (Action(tabClose: true), Pattern(data: [Vector.Bottom, Vector.Right])),
    (Action(tabCloseAll: true), Pattern(data: [Vector.Bottom, Vector.Right, Vector.Top])),
    (Action(tabOpen: true), Pattern(data: [Vector.Bottom, Vector.Left])),
    (Action(tabDuplicate: true), Pattern(data: [Vector.Bottom, Vector.Left, Vector.Top]))
]
