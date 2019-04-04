//
//  AlbumTests.swift
//  DeezerExerciceTests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest

final class AlbumTests: XCTestCase {
    
    /**
     Test to create an album with a json string.
     */
    func testInitAlbum() {
        let jsonString = """
        {
            "id": 6575789,
            "title": "Random Access Memories",
            "link": "https://www.deezer.com/album/6575789",
            "cover": "https://api.deezer.com/album/6575789/image",
            "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/56x56-000000-80-0-0.jpg",
            "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/250x250-000000-80-0-0.jpg",
            "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/500x500-000000-80-0-0.jpg",
            "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/1000x1000-000000-80-0-0.jpg",
            "genre_id": 106,
            "fans": 721167,
            "release_date": "2013-05-17",
            "record_type": "album",
            "tracklist": "https://api.deezer.com/album/6575789/tracks",
            "explicit_lyrics": false,
            "type": "album"
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Cannot transform json string to data")
            return
        }
        
        guard let album = try? JSONDecoder().decode(Album.self, from: data) else {
            XCTFail("Cannot decode json data")
            return
        }
        
        XCTAssertEqual(album.identifier, 6575789, "Wrong album identifier")
        XCTAssertEqual(album.title, "Random Access Memories", "Wrong album title")
        XCTAssertEqual(album.coverUrlBig, "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/500x500-000000-80-0-0.jpg", "Wrong album cover url big")
        XCTAssertEqual(album.fans, 721167, "Wrong album fans number")
        XCTAssertEqual(album.releaseDate, "2013-05-17", "Wrong albbum release date")
    }
    
    /**
     Test to create an album with a json string.
     */
    func testInitAlbumList() {
        let jsonString = """
        {
            "data": [
                {
                    "id": 6575789,
                    "title": "Random Access Memories",
                    "link": "https://www.deezer.com/album/6575789",
                    "cover": "https://api.deezer.com/album/6575789/image",
                    "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/56x56-000000-80-0-0.jpg",
                    "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/250x250-000000-80-0-0.jpg",
                    "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/500x500-000000-80-0-0.jpg",
                    "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/b298094528702627877720d0be4448b5/1000x1000-000000-80-0-0.jpg",
                    "genre_id": 106,
                    "fans": 721167,
                    "release_date": "2013-05-17",
                    "record_type": "album",
                    "tracklist": "https://api.deezer.com/album/6575789/tracks",
                    "explicit_lyrics": false,
                    "type": "album"
                },
                {
                    "id": 936927,
                    "title": "TRON Legacy: Reconfigured",
                    "link": "https://www.deezer.com/album/936927",
                    "cover": "https://api.deezer.com/album/936927/image",
                    "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/0ccd883386360849fa115e65cd795a20/56x56-000000-80-0-0.jpg",
                    "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/0ccd883386360849fa115e65cd795a20/250x250-000000-80-0-0.jpg",
                    "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/0ccd883386360849fa115e65cd795a20/500x500-000000-80-0-0.jpg",
                    "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/0ccd883386360849fa115e65cd795a20/1000x1000-000000-80-0-0.jpg",
                    "genre_id": 173,
                    "fans": 47436,
                    "release_date": "2011-04-01",
                    "record_type": "album",
                    "tracklist": "https://api.deezer.com/album/936927/tracks",
                    "explicit_lyrics": false,
                    "type": "album"
                }
            ]
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Cannot transform json string to data")
            return
        }
        
        guard let albumList = try? JSONDecoder().decode(AlbumList.self, from: data) else {
            XCTFail("Cannot decode json data")
            return
        }
        
        XCTAssertEqual(albumList.data.count, 2, "Wrong albums numbers")
        
        XCTAssertEqual(albumList.data[0].identifier, 6575789, "Wrong identifier for first album")
        XCTAssertEqual(albumList.data[1].identifier, 936927, "Wrong identifier for second album")
    }
    
}

