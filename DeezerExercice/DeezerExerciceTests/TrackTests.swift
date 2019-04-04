//
//  TrackTests.swift
//  DeezerExerciceTests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest

final class TrackTests: XCTestCase {
    
    func testInitTrack() {
        let jsonString = """
        {
            "id": 3135553,
            "readable": true,
            "title": "One More Time",
            "title_short": "One More Time",
            "title_version": "",
            "isrc": "GBDUW0000053",
            "link": "https://www.deezer.com/track/3135553",
            "duration": 320,
            "track_position": 1,
            "disk_number": 1,
            "rank": 851865,
            "explicit_lyrics": false,
            "explicit_content_lyrics": 0,
            "explicit_content_cover": 0,
            "preview": "https://cdns-preview-e.dzcdn.net/stream/c-e77d23e0c8ed7567a507a6d1b6a9ca1b-7.mp3",
            "artist": {
                "id": 27,
                "name": "Daft Punk",
                "tracklist": "https://api.deezer.com/artist/27/top?limit=50",
                "type": "artist"
            },
            "type": "track"
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Cannot transform json string to data")
            return
        }
        
        guard let track = try? JSONDecoder().decode(Track.self, from: data) else {
            XCTFail("Cannot decode json data")
            return
        }
        
        XCTAssertEqual(track.identifier, 3135553, "Wrong track identifier")
        XCTAssertEqual(track.title, "One More Time", "Wrong trac title")
        XCTAssertEqual(track.duration, 320, "Wrong track duration")
        XCTAssertEqual(track.trackPosition, 1, "Wrong track position")
        XCTAssertEqual(track.diskNumber, 1, "Wrong track disk number")
        XCTAssertEqual(track.previewUrl, "https://cdns-preview-e.dzcdn.net/stream/c-e77d23e0c8ed7567a507a6d1b6a9ca1b-7.mp3", "Wrong track preview url")
    }
    
    func testInitTrackList() {
        let jsonString = """
        {
            "data": [
                {
                    "id": 3135553,
                    "readable": true,
                    "title": "One More Time",
                    "title_short": "One More Time",
                    "title_version": "",
                    "isrc": "GBDUW0000053",
                    "link": "https://www.deezer.com/track/3135553",
                    "duration": 320,
                    "track_position": 1,
                    "disk_number": 1,
                    "rank": 851865,
                    "explicit_lyrics": false,
                    "explicit_content_lyrics": 0,
                    "explicit_content_cover": 0,
                    "preview": "https://cdns-preview-e.dzcdn.net/stream/c-e77d23e0c8ed7567a507a6d1b6a9ca1b-7.mp3",
                    "artist": {
                        "id": 27,
                        "name": "Daft Punk",
                        "tracklist": "https://api.deezer.com/artist/27/top?limit=50",
                        "type": "artist"
                    },
                    "type": "track"
                },
                {
                    "id": 3135554,
                    "readable": true,
                    "title": "Aerodynamic",
                    "title_short": "Aerodynamic",
                    "title_version": "",
                    "isrc": "GBDUW0000057",
                    "link": "https://www.deezer.com/track/3135554",
                    "duration": 212,
                    "track_position": 2,
                    "disk_number": 1,
                    "rank": 769460,
                    "explicit_lyrics": false,
                    "explicit_content_lyrics": 6,
                    "explicit_content_cover": 0,
                    "preview": "https://cdns-preview-b.dzcdn.net/stream/c-b2e0166bba75a78251d6dca9c9c3b41a-5.mp3",
                    "artist": {
                        "id": 27,
                        "name": "Daft Punk",
                        "tracklist": "https://api.deezer.com/artist/27/top?limit=50",
                        "type": "artist"
                    },
                    "type": "track"
                }
            ]
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Cannot transform json string to data")
            return
        }
        
        guard let trackList = try? JSONDecoder().decode(TrackList.self, from: data) else {
            XCTFail("Cannot decode json data")
            return
        }
        
        XCTAssertEqual(trackList.data.count, 2, "Wrong tracks number")
        
        XCTAssertEqual(trackList.data[0].identifier, 3135553, "Wrong identifier for first track")
        XCTAssertEqual(trackList.data[1].identifier, 3135554, "Wrong identifier for second track")
    }
    
}
