//
//  TrackCell.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

protocol TrackCellProtocol {
    func display(title: String)
}

final class TrackCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = .clear
    }
}

extension TrackCell: TrackCellProtocol {
    func display(title: String) {
        self.titleLabel.text = title
    }
}
