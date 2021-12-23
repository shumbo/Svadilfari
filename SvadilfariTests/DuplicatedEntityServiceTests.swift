//
//  DuplicatedEntityServiceTests.swift
//  SvadilfariTests
//
//  Created by Shun Kashiwa on 2021/12/23.
//

import XCTest
import CoreData

class DuplicatedEntityServiceTests: XCTestCase {

    private var viewContext: NSManagedObjectContext!
    private var ud: UserDefaults!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: "CoreData")
        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.viewContext = container.viewContext

        self.ud = UserDefaults(suiteName: #file)
        self.ud.removePersistentDomain(forName: #file)

        print("jjjjjjjjjjjj")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDuplicatedGestures() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(self.viewContext != nil)
        var action = Action()
        action.goForward = true
        let gesture = Gesture(action: action, enabled: true, id: "id 1", pattern: Pattern(data: [Vector.Top]))
        let e1 = GestureEntity(context: self.viewContext)
        let e2 = GestureEntity(context: self.viewContext)
        e1.json = try? gesture.jsonString()
        e2.json = try? gesture.jsonString()
        try? self.viewContext.save()

        let initialResult = try self.viewContext.fetch(GestureEntity.fetchRequest())
        XCTAssertEqual(initialResult.count, 2)

        DuplicatedEntityService(viewContext: self.viewContext).removeDuplicatedEntities()

        let removedResult = try self.viewContext.fetch(GestureEntity.fetchRequest())
        XCTAssertEqual(removedResult.count, 1)
    }
}
