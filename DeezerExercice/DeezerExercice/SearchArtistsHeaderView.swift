//
//  SearchArtistsHeaderView.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

protocol SearchArtistsHeaderViewProtocol {
    
    /**
     Display information on the view.
     
     - parameters:
         - title: Section name.
     */
    func display(title: String)
}

@objcMembers final class SearchArtistsHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            titleLabel.textColor = DZRColors.white
            titleLabel.alpha = 0
            titleLabel.font = DZRFonts.largeHeavy
        }
    }
    
}

extension SearchArtistsHeaderView: SearchArtistsHeaderViewProtocol {
    func display(title: String) {
        self.titleLabel.text = title
        
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.alpha = 1
            
            self.layoutIfNeeded()
        }
    }
}
