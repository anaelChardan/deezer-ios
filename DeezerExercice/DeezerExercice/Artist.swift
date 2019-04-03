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
    var pictureUrl: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case pictureUrl = "picture_medium"
    }
}

