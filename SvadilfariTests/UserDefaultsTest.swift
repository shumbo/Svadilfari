//
//  UserDefaultsTest.swift
//  SvadilfariTests
//
//  Created by Shun Kashiwa on 2021/12/23.
//

import XCTest

class UserDefaultsTest: XCTestCase {

    private var ud: UserDefaults!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.ud = UserDefaults(suiteName: #file)
        self.ud.removePersistentDomain(forName: #file)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefault() throws {
        UserDefaults.setInitialData(defaults: self.ud)
        XCTAssertEqual(self.ud.isFirstLaunch, true)
        XCTAssertEqual(self.ud.icloudSyncEnabled, true)
    }

    func testAlreadyLaunched() throws {
        self.ud.isFirstLaunch = false
        UserDefaults.setInitialData(defaults: self.ud)
        XCTAssertEqual(self.ud.icloudSyncEnabled, false)
    }

}
