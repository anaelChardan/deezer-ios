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
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
    }
}

