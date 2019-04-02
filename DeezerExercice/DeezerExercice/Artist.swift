//
//  Artist.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

struct ArtistList: Codable {
    let data: [Artist]
}

struct Artist: Codable {
    
    //MARK : - Properties -
    var identifier: Int
    var name: String
    var pictureUrl: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case pictureUrl = "picture"
    }
}

