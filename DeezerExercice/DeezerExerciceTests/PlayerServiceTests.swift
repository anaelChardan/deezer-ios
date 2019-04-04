//
//  PlayerServiceTests.swift
//  DeezerExerciceTests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest

class PlayerServiceTests: XCTestCase {
    
    /**
     Test to play a track from the remote server.
     */
    func testPlaySongFromRemoteUrl() {
        PlayerService
            .shared
            .play(withStringUrl: "https://cdns-preview-e.dzcdn.net/stream/c-e77d23e0c8ed7567a507a6d1b6a9ca1b-7.mp3")
        
        XCTAssertTrue(PlayerService.shared.isPlaying, "Player is not playing")
    }
    
    /**
     Test to pause a playing song.
     */
    func testPlayerCanPauseASong() {
        PlayerService
            .shared
            .play(withStringUrl: "https://cdns-preview-e.dzcdn.net/stream/c-e77d23e0c8ed7567a507a6d1b6a9ca1b-7.mp3")
        
        XCTAssertTrue(PlayerService.shared.isPlaying, "Player is not playing")
        
        PlayerService
            .shared
            .pause()
        
        XCTAssertFalse(PlayerService.shared.isPlaying, "Player should not play")
    }
    
}
