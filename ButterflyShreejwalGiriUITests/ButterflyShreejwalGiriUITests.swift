//
//  ButterflyShreejwalGiriUITests.swift
//  ButterflyShreejwalGiriUITests
//
//  Created by shreejwal giri on 14/03/2024.
//

import XCTest

final class ButterflyShreejwalGiriUITests: XCTestCase {

    // MARK: testing if the movie list in loaded in the tableview
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables.element
        XCTAssertTrue(tableView.waitForExistence(timeout: 10), "Table view does not exist")
        
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "First cell does not exist")
        XCTAssertTrue(firstCell.exists, "Table view is loaded and contains list")
    }



}
