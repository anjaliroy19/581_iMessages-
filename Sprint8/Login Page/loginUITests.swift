//
//  loginUITests.swift
//  loginUITests
//
// Created by Divya Shakamuri on 02/10/23
//

import XCTest

class loginUITests: XCTestCase {

    override func setUpWithError() throws {

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
