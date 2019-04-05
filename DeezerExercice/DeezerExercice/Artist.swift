//
//  Artist.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

@objcMembers class ArtistList: NSObject, Codable {
    let data: [Artist]
}

@objcMembers class Artist: NSObject, Codable {
    
    // MARK: - Properties
    var identifier: Int
    var name: String
    var pictureUrlBig: String
    var pictureUrlMedium: String
    var fans: Int
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case pictureUrlBig = "picture_big"
        case pictureUrlMedium = "picture_medium"
        case fans = "nb_fan"
    }
}
