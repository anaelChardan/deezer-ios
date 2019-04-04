//
//  CacheServiceTests.swift
//  DeezerExerciceTests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest
import UIKit

class CacheServiceTests: XCTestCase {
    
    /**
     Test to store and retreive an image in cache.
     */
    func testSaveAndGetUIImage() {
        guard let image = UIImage(named: "icon_left") else {
            XCTFail("Failed to load image")
            return
        }
        
        CacheService
            .shared
            .save(image: image, forKey: "icon_left")
        
        XCTAssertNotNil(CacheService.shared.get(forKey: "icon_left"), "Image should not be nil")
    }
    
}

