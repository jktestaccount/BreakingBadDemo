//
//  BreakingBadDemoUITests.swift
//  BreakingBadDemoUITests
//
//  Created by Juan Kruger on 05/08/2021.
//

import XCTest

class BreakingBadDemoUITests: XCTestCase {

    func testMasterAndDetailLoad() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        sleep(4) // Time for data to load
        
        let tableCells = app.tables.element(boundBy: 0).cells
        XCTAssertTrue(tableCells.count > 0, "Table did not populate")
        tableCells.element(boundBy: 0).tap()

        let occupationLabel = app.staticTexts["occupationLabel"]
        XCTAssertTrue(occupationLabel.exists, "Occupation label did not load")
        XCTAssertTrue(occupationLabel.label.count > 0, "Occupation label did not populate")
    }
}
