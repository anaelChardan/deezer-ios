//
//  OtherArtistCell.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

protocol OtherArtistCellProtocol: class {
    func display(name: String, pictureUrl: String)
}

@objcMembers final class OtherArtistCell: UICollectionViewCell {
    
    @IBOutlet weak var artistDZRImageView: DZRImageView! {
        didSet {
            artistDZRImageView.contentMode = .scaleAspectFill
            artistDZRImageView.clipsToBounds = true
            artistDZRImageView.layer.cornerRadius = artistDZRImageView.frame.width / 2
            artistDZRImageView.alpha = 0
        }
    }
    
    @IBOutlet weak var artistNameLabel: UILabel! {
        didSet {
            artistNameLabel.textColor = DZRColors.white
            artistNameLabel.font = DZRFonts.normalMedium
            artistNameLabel.alpha = 0
        }
    }
    
}

extension OtherArtistCell: OtherArtistCellProtocol {
    func display(name: String, pictureUrl: String) {
        self.artistNameLabel.text = name
        
        UIView.animate(withDuration: 0.2) {
            self.artistNameLabel.alpha = 1
            
            self.layoutIfNeeded()
        }
        
        self.artistDZRImageView.loadAsync(withStringUrl: pictureUrl) {
            UIView.animate(withDuration: 0.2, animations: {
                self.artistDZRImageView.alpha = 1
                
                self.layoutIfNeeded()
            })
        }
    }
}

