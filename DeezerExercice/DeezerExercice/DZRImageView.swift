//
//  DZRImageView.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

//TODO check [weak self] for every closures

@objcMembers class DZRImageView: UIImageView {
    
    // MARK: - Properties
    private var stringUrl: String?
    
    // MARK: - Methods
    @objc func loadAsync(withStringUrl stringUrl: String, completionSuccess: (() -> Void)?) {
        self.stringUrl = stringUrl
        self.image = nil
        
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
                if self?.stringUrl == stringUrl {
                    self?.image = image
                    completionSuccess?()
                }
            }
        }
    }
}
