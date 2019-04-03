//
//  TrackCell.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

protocol TrackCellProtocol {
    func display(trackPosition: String, title: String, duration: String, isHighlight: Bool)
}

final class TrackCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var trackPositionLabel: UILabel! {
        didSet {
            trackPositionLabel.textColor = DZRColors.grey.withAlphaComponent(0.7)
            trackPositionLabel.font = DZRFonts.mediumLight
            trackPositionLabel.alpha = 0
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = DZRColors.white
            titleLabel.font = DZRFonts.medium
            titleLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var durationLabel: UILabel! {
        didSet {
            durationLabel.textColor = DZRColors.grey.withAlphaComponent(0.7)
            durationLabel.font = DZRFonts.mediumLight
            durationLabel.alpha = 0
        }
    }
    
    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = DZRColors.purple
        selectionStyle = .none
    }
}

extension TrackCell: TrackCellProtocol {
    func display(trackPosition: String, title: String, duration: String, isHighlight: Bool) {
        self.trackPositionLabel.text = trackPosition
        self.titleLabel.text = title
        self.durationLabel.text = duration

        self.titleLabel.textColor = isHighlight ? DZRColors.pink : DZRColors.white
        
        UIView.animate(withDuration: 0.2) {
            self.trackPositionLabel.alpha = 1
            self.titleLabel.alpha = 1
            self.durationLabel.alpha = 1
            
            self.layoutIfNeeded()
        }
    }
}
