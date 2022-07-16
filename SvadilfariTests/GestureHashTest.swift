//
//  GestureHashTest.swift
//  SvadilfariTests
//
//  Test hash function of Gesture
//
//  Created by Shun Kashiwa on 2021/12/23.
//

import XCTest

class GestureHashTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetectSameGesture() throws {
        var action = Action()
        action.goBackward = true
        let g1 = Gesture(action: action, enabled: true, id: "id 1", pattern: Pattern(data: [Vector(x: 10.0, y: 20.0)]))
        let g2 = Gesture(action: action, enabled: true, id: "id 2", pattern: Pattern(data: [Vector(x: 10.0, y: 20.0)]))
        XCTAssertEqual(g1.contentHash, g2.contentHash)
    }

    func testDetectDifferentPattern() throws {
        var action = Action()
        action.goBackward = true
        let g1 = Gesture(action: action, enabled: true, id: "id 1", pattern: Pattern(data: [Vector(x: 10.1, y: 20.0)]))
        let g2 = Gesture(action: action, enabled: true, id: "id 1", pattern: Pattern(data: [Vector(x: 10.2, y: 20.0)]))
        XCTAssertNotEqual(g1.contentHash, g2.contentHash)
    }

    func testDetectDifferentAction() throws {
        var a1 = Action()
        a1.goBackward = true
        var a2 = Action()
        a2.goForward = true
        let g1 = Gesture(action: a1, enabled: true, id: "id 1", pattern: Pattern(data: [Vector(x: 10.1, y: 20.0)]))
        let g2 = Gesture(action: a2, enabled: true, id: "id 1", pattern: Pattern(data: [Vector(x: 10.1, y: 20.0)]))
        XCTAssertNotEqual(g1.contentHash, g2.contentHash)
    }

    func testDetectDifferentStatus() throws {
        var a1 = Action()
        a1.goBackward = true
        let g1 = Gesture(action: a1, enabled: true, id: "id 1", pattern: Pattern(data: [Vector(x: 10.1, y: 20.0)]))
        let g2 = Gesture(action: a1, enabled: false, id: "id 1", pattern: Pattern(data: [Vector(x: 10.1, y: 20.0)]))
        XCTAssertNotEqual(g1.contentHash, g2.contentHash)
    }

}
