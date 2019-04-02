//
//  TrackCell.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

protocol TrackCellProtocol {
    func display(trackPosition: String, title: String, duration: String)
}

final class TrackCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var trackPositionLabel: UILabel! {
        didSet {
            trackPositionLabel.textColor = DZRColors.grey.withAlphaComponent(0.7)
            trackPositionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = DZRColors.white
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
    
    @IBOutlet weak var durationLabel: UILabel! {
        didSet {
            durationLabel.textColor = DZRColors.grey.withAlphaComponent(0.7)
            durationLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
    }
    
    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = DZRColors.purple
    }
}

extension TrackCell: TrackCellProtocol {
    func display(trackPosition: String, title: String, duration: String) {
        self.trackPositionLabel.text = trackPosition
        self.titleLabel.text = title
        self.durationLabel.text = duration
    }
}
