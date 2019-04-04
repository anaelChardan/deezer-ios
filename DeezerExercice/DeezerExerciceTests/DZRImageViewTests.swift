//
//  DZRImageViewTests.swift
//  DeezerExerciceTests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest

class DZRImageViewTests: XCTestCase {
    
    func testLoadImageAsync() {
        let dzrImageView = DZRImageView()
        let expectation = self.expectation(description: "Fetch image")
        
        XCTAssertNil(dzrImageView.image, "Image should be nil")
        
        dzrImageView.loadAsync(withStringUrl: "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/56x56-000000-80-0-0.jpg") {
            XCTAssertNotNil(dzrImageView.image, "Image should not be nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
