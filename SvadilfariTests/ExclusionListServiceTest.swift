//
//  ExclusionListServiceTest.swift
//  ExclusionListServiceTest
//
//  Created by Shun Kashiwa on 2021/08/20.
//

import XCTest
import CoreData

@testable import Svadilfari

class ExclusionListServiceTests: XCTestCase {

    private var moc: NSManagedObjectContext!
    private var els: ExclusionListService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "CoreData")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.moc = container.newBackgroundContext()
        self.els = ExclusionListService(moc: container.viewContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddPageEntry() throws {
        try self.els.add(domain: "example.com", path: "/foo")
        let e = try self.els.fetchRelevantEntry(domain: "example.com", path: "/foo")
        XCTAssertEqual(e?.domain, "example.com")
        XCTAssertEqual(e?.path, "/foo")
    }

    func testAddDomainEntry() throws {
        try self.els.add(domain: "example.com", path: nil)
        let e = try self.els.fetchRelevantEntry(domain: "example.com", path: "/")
        XCTAssertNotNil(e)
        XCTAssertEqual(e?.domain, "example.com")
        XCTAssertNil(e?.path)
    }

    func testAddDomainEntryRemovingEntries() throws {
        try self.els.add(domain: "example.com", path: "/foo")
        try self.els.add(domain: "example.com", path: "/bar")
        try self.els.add(domain: "example.com", path: nil)

        let foo = try self.els.fetchRelevantEntry(domain: "example.com", path: "/foo")
        XCTAssertNotNil(foo)
        XCTAssertNil(foo?.path)
        let bar = try self.els.fetchRelevantEntry(domain: "example.com", path: "/bar")
        XCTAssertNotNil(bar)
        XCTAssertNil(foo?.path)
    }

    func testFetchDomainEntry() throws {
        // add a page entry
        try self.els.add(domain: "example.com", path: "/bar")
        let e = try self.els.fetchRelevantEntry(domain: "example.com", path: "/")
        XCTAssertNil(e)
    }
}
