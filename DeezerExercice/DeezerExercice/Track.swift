//
//  Track.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

struct TrackList: Codable {
    let data: [Track]
}

struct Track: Codable {
    
    // MARK: - Properties
    var identifier: Int
    var title: String
    var trackPosition: Int
    var duration: Int
    var diskNumber: Int
    var previewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case trackPosition = "track_position"
        case duration
        case diskNumber = "disk_number"
        case previewUrl = "preview"
    }
}
