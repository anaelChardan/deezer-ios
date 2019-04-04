//
//  CacheService.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import UIKit
import Foundation

protocol CacheServiceProtocol: class {
    
    func save(image: UIImage, forKey key: String)
    func get(forKey key: String) -> UIImage?
    
}

class CacheService: CacheServiceProtocol {
    
    // MARK: - Properties
    static let shared: CacheServiceProtocol = CacheService()
    
    private var imageCache: NSCache<NSString, UIImage>
    
    // MARK: - Lifecycle
    private init() {
        imageCache = NSCache()
    }
    
    // MARK: - Methods
    
    /**
     Save an image in memory cache.
     
     - parameters:
        - image: Image to save.
        - key: String to store the image to cache.
     */
    func save(image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    /**
     Get a saved image from cache.
     
     - returns:
     The image stored in cache. Could be nil.
     
     - parameters:
        - key: String to retreive the image from cache.
     */
    func get(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
