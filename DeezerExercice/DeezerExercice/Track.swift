//
//  Track.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import Foundation

struct Track: Codable {
    
    //MARK : - Properties -
    let title: String
    
    // MARK: - Lifecycle -
    init(dict: [String: Any]) {
        self.title = dict["title"] as? String ?? ""
    }
}

