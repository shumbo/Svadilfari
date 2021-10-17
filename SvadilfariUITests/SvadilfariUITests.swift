//
//  SvadilfariUITests.swift
//  SvadilfariUITests
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import XCTest

class SvadilfariUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state
        // - such as interface orientation - required for your tests before they run.
        // The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func getLocale(app: XCUIApplication) -> String {
        guard let localeArgIdx = app.launchArguments.firstIndex(of: "-AppleLocale") else {
            return "?"
        }
        if localeArgIdx >= app.launchArguments.count {
            return "?"
        }
        let str = app.launchArguments[localeArgIdx + 1]
        let start = str.index(str.startIndex, offsetBy: 1)
        let end = str.index(start, offsetBy: 2)
        let range = start..<end

        let locale = str[range]
        return String(locale)
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["SHOW_TUTORIAL"]
        setupSnapshot(app)
        app.launch()

        // get current language from arguments
        func localized(_ key: String) -> String {
            let locale = getLocale(app: app)
            let testBundle = Bundle(for: Self.self)
            if let testBundlePath = testBundle.path(forResource: locale, ofType: "lproj"),
               let localizedBundle = Bundle(path: testBundlePath) {
                return NSLocalizedString(key, bundle: localizedBundle, comment: "")
            }
            return "?"
        }

        snapshot("1-Tutorial")

        // go to the last screen
        for _ in 0..<3 {
            app.buttons[localized("COMMON_CONTINUE")].firstMatch.tap()
        }
        app.buttons[localized("TUTORIAL_DONE_VIEW_GESTURES")].firstMatch.tap()

        app.navigationBars.buttons.firstMatch.tap()

        snapshot("2-Home")

        app.tables.cells.element(boundBy: 2).tap()

        snapshot("3-Gestures")

        // Plus Button
        app.navigationBars.buttons.element(boundBy: 1).tap()

        // Select Pattern from Presets
        app.buttons[localized("NEW_GESTURE_SELECT_PATTERN_BUTTON")].firstMatch.tap()

        // Top Left Pattern
        app.staticTexts[localized("PATTERN_PRESET_UP_LEFT")].tap()

        snapshot("4-Pattern")

        // Continue
        app.buttons[localized("PREVIEW_PATTERN_USE")].firstMatch.tap()

        snapshot("5-Actions")
    }

}

var currentLanguage: (langCode: String, localeCode: String)? {
    let currentLocale = Locale(identifier: Locale.preferredLanguages.first!)
    guard let langCode = currentLocale.languageCode else {
        return nil
    }
    var localeCode = langCode
    if let scriptCode = currentLocale.scriptCode {
        localeCode = "\(langCode)-\(scriptCode)"
    } else if let regionCode = currentLocale.regionCode {
        localeCode = "\(langCode)-\(regionCode)"
    }
    return (langCode, localeCode)
}
