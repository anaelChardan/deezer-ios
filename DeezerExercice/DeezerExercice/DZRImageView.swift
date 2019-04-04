//
//  DZRImageView.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

@objcMembers class DZRImageView: UIImageView {
    
    // MARK: - Properties
    private var stringUrl: String?
    
    // MARK: - Methods
    
    /**
     Load an image from a remote URL in background thread.
     
     - parameters:
        - stringUrl: The url where the image is located online.
        - completionSuccess: Code that will be executed in case of success in the main thread.
     */
    @objc func loadAsync(withStringUrl stringUrl: String, completionSuccess: (() -> Void)?) {
        self.stringUrl = stringUrl
        self.image = nil
        
        //If the image is already in cache, return it directly.
        if let imageFromCache = CacheService.shared.get(forKey: stringUrl) {
            self.image = imageFromCache
            completionSuccess?()
            return
        }
        
        //Else, download it in background thread and show it in main thread.
        guard let url = URL(string: stringUrl) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                //Be sure that the downloaded image is the image to show.
                if self?.stringUrl == stringUrl {
                    self?.image = image
                    CacheService
                        .shared
                        .save(image: image, forKey: stringUrl)
                    completionSuccess?()
                }
            }
        }
    }
}
