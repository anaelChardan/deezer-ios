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
        
        let davidGuettaStaticText = app.staticTexts["David Guetta"]
        
        let existsPredicate = NSPredicate(format: "exists == 1")
        
        expectation(for: existsPredicate, evaluatedWith: davidGuettaStaticText, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        davidGuettaStaticText.tap()
        
        let albumTitleLabel = app.staticTexts["albumTitleLabel"]
        let fansValueLabel = app.staticTexts["fansValueLabel"]
        let releaseDateValueLabel = app.staticTexts["releaseDateValueLabel"]
        
        expectation(for: existsPredicate, evaluatedWith: albumTitleLabel, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: fansValueLabel, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: releaseDateValueLabel, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        XCTAssertTrue(albumTitleLabel.exists, "Album title should be display")
        XCTAssertTrue(fansValueLabel.exists, "Album fans number should be display")
        XCTAssertTrue(releaseDateValueLabel.exists, "Release date should be display")
    }

}
