//
//  ArtistTests.swift
//  DeezerExerciceTests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest

final class ArtistTests: XCTestCase {
    
    /**
     Test to create an artist with a json string.
     */
    func testInitArtist() {
        let jsonString = """
        {
            "id": 5004,
            "name": "D'Angelo",
            "link": "https://www.deezer.com/artist/5004",
            "picture": "https://api.deezer.com/artist/5004/image",
            "picture_small": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/56x56-000000-80-0-0.jpg",
            "picture_medium": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/250x250-000000-80-0-0.jpg",
            "picture_big": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/500x500-000000-80-0-0.jpg",
            "picture_xl": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/1000x1000-000000-80-0-0.jpg",
            "nb_album": 10,
            "nb_fan": 64221,
            "radio": true,
            "tracklist": "https://api.deezer.com/artist/5004/top?limit=50",
            "type": "artist"
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Cannot transform json string to data")
            return
        }
        
        guard let artist = try? JSONDecoder().decode(Artist.self, from: data) else {
            XCTFail("Cannot decode json data")
            return
        }

        XCTAssertEqual(artist.identifier, 5004, "Wrong artist identifier")
        XCTAssertEqual(artist.name, "D'Angelo", "Wrong artist name")
        XCTAssertEqual(artist.pictureUrlBig, "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/500x500-000000-80-0-0.jpg", "Wrong artist pictureUrlBig")
        XCTAssertEqual(artist.fans, 64221, "Wrong artist fans")
    }
    
    /**
     Test to create a artists with a json string.
     */
    func testInitArtistList() {
        let jsonString = """
        {
            "data": [
                {
                    "id": 5004,
                    "name": "D'Angelo",
                    "link": "https://www.deezer.com/artist/5004",
                    "picture": "https://api.deezer.com/artist/5004/image",
                    "picture_small": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/56x56-000000-80-0-0.jpg",
                    "picture_medium": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/250x250-000000-80-0-0.jpg",
                    "picture_big": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/500x500-000000-80-0-0.jpg",
                    "picture_xl": "https://cdns-images.dzcdn.net/images/artist/e12a0883c1215aa2640e87516fc7499d/1000x1000-000000-80-0-0.jpg",
                    "nb_album": 10,
                    "nb_fan": 64221,
                    "radio": true,
                    "tracklist": "https://api.deezer.com/artist/5004/top?limit=50",
                    "type": "artist"
                },
                {
                    "id": 140,
                    "name": "Gigi D'Agostino",
                    "link": "https://www.deezer.com/artist/140",
                    "picture": "https://api.deezer.com/artist/140/image",
                    "picture_small": "https://cdns-images.dzcdn.net/images/artist//56x56-000000-80-0-0.jpg",
                    "picture_medium": "https://cdns-images.dzcdn.net/images/artist//250x250-000000-80-0-0.jpg",
                    "picture_big": "https://cdns-images.dzcdn.net/images/artist//500x500-000000-80-0-0.jpg",
                    "picture_xl": "https://cdns-images.dzcdn.net/images/artist//1000x1000-000000-80-0-0.jpg",
                    "nb_album": 36,
                    "nb_fan": 124302,
                    "radio": true,
                    "tracklist": "https://api.deezer.com/artist/140/top?limit=50",
                    "type": "artist"
                }
            ]
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Cannot transform json string to data")
            return
        }
        
        guard let artistList = try? JSONDecoder().decode(ArtistList.self, from: data) else {
            XCTFail("Cannot decode json data")
            return
        }
        
        XCTAssertEqual(artistList.data.count, 2, "Wrong artists number")
        
        XCTAssertEqual(artistList.data[0].identifier, 5004, "Wrong identifier for first artist")
        XCTAssertEqual(artistList.data[1].identifier, 140, "Wrong identifier for second artist")
    }
    
}
