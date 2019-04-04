//
//  DeezerExerciceUITests.swift
//  DeezerExerciceUITests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest

class DeezerExerciceUITests: XCTestCase {

    // MARK: - Properties
    private var app: XCUIApplication!
    
    // MARK: - Methods
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    func testCanShowAlbumOfDavidGuetta() {
        app.buttons["searchButton"].tap()
        app.navigationBars.element.typeText("David Guetta")
        app.staticTexts["David Guetta"].tap()
        
        XCTAssertTrue(app.staticTexts["Flames"].exists, "Flames track should be display")
        XCTAssertTrue(app.staticTexts["7"].exists, "Album title should be display")
        XCTAssertTrue(app.staticTexts[String(format: "%d", locale: Locale.current, 73671)].exists, "Fans number should be display")
        XCTAssertTrue(app.staticTexts["14/09/2018"].exists, "Release should be display or not well formated")
    }

}
