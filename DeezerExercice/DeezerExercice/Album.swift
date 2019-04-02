//
//  Album.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

struct AlbumList: Codable {
    let data: [Album]
}

struct Album: Codable {
    
    //MARK : - Properties -
    var identifier: Int
    var title: String
    var coverSmall: String
    var coverBig: String
    var fans: Int
    var releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case coverSmall = "cover_small"
        case coverBig = "cover_big"
        case fans
        case releaseDate = "release_date"
    }
}

