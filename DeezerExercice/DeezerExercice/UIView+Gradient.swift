//
//  UIView+Gradient.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

@objc extension UIView {
    func gradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map({ $0.cgColor })
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
