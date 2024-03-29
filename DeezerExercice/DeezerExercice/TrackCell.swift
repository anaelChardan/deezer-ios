//
//  TrackCell.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

protocol TrackCellProtocol {
    /**
     Display information to the view.
     
     - parameters:
        - trackPosition: The tracks' position.
        - title: The tracks' position.
        - duration: The tracks' duration.
        - isHighlight: Determine the color of the titleLabel depending on the track status. Play or pause.
     */
    func display(trackPosition: String, title: String, duration: String, isHighlight: Bool)
}

final class TrackCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var trackPositionLabel: UILabel! {
        didSet {
            trackPositionLabel.textColor = DZRColors.grey.withAlphaComponent(0.7)
            trackPositionLabel.font = DZRFonts.normalLight
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
            durationLabel.font = DZRFonts.normalLight
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
