//
//  NetworkServiceTests.swift
//  DeezerExerciceTests
//
//  Created by Maxime Maheo on 04/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import XCTest

final class NetworkServiceTests: XCTestCase {
    
    
    // MARK: - Test fetch albums
    func testFetchAlbums() {
        let expectation = self.expectation(description: "Fetch albums")
        
        NetworkService
            .shared
            .fetchAlbums(withArtistId: 27) { (result) in
                switch result {
                case .success(let albums):
                    XCTAssertFalse(albums.data.isEmpty, "Albums data is empty")
                    
                    XCTAssertEqual(albums.data.first?.identifier, 6575789, "Wrong album identifier")
                    XCTAssertEqual(albums.data.first?.title, "Random Access Memories", "Wrong album title")
                    
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchAlbumsWithWrongArtistId() {
        let expectation = self.expectation(description: "Fetch albums")
        
        NetworkService
            .shared
            .fetchAlbums(withArtistId: -1) { (result) in
                switch result {
                case .success:
                    XCTFail("Should fail")
                case .failure(let error):
                    XCTAssertNotNil(error)
                    
                    expectation.fulfill()
                }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test fetch artists
    func testFetchArtists() {
        let expectation = self.expectation(description: "Fetch artists")
        
        NetworkService
            .shared
            .fetchArtists(withQuery: "Eminem", completion: { (result) in
                switch result {
                case .success(let artists):
                    XCTAssertFalse(artists.data.isEmpty, "Artists data is empty")
                    
                    XCTAssertEqual(artists.data.first?.identifier, 13, "Wrong artist identifier")
                    XCTAssertEqual(artists.data.first?.name, "Eminem", "Wrong artist name")
                    
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchArtistsWithSpaceInName() {
        let expectation = self.expectation(description: "Fetch artists")
        
        NetworkService
            .shared
            .fetchArtists(withQuery: "David Guetta", completion: { (result) in
                switch result {
                case .success(let artists):
                    XCTAssertFalse(artists.data.isEmpty, "Artists data is empty")
                    
                    XCTAssertEqual(artists.data.first?.identifier, 542, "Wrong artist identifier")
                    XCTAssertEqual(artists.data.first?.name, "David Guetta", "Wrong artist name")
                    
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchArtistsWithWrongQuery() {
        let expectation = self.expectation(description: "Fetch artists")
        
        NetworkService
            .shared
            .fetchArtists(withQuery: "eoipfhzef", completion: { (result) in
                switch result {
                case .success(let artists):
                    XCTAssertTrue(artists.data.isEmpty, "Artists data should be empty")
                    
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test fetch tracks
    func testFetchTracks() {
        let expectation = self.expectation(description: "Fetch tracks")
        
        NetworkService
            .shared
            .fetchTracks(withAlbumId: 302127, completion: { (result) in
                switch result {
                case .success(let tracks):
                    XCTAssertFalse(tracks.data.isEmpty, "Tracks data is empty")
                    
                    XCTAssertEqual(tracks.data.first?.identifier, 3135553, "Wrong tracks identifier")
                    XCTAssertEqual(tracks.data.first?.title, "One More Time", "Wrong tracks title")
                    
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchTracksWithWrongAlbumId() {
        let expectation = self.expectation(description: "Fetch tracks")
        
        NetworkService
            .shared
            .fetchTracks(withAlbumId: -1, completion: { (result) in
                switch result {
                case .success:
                    XCTFail("Should fail")
                case .failure(let error):
                    XCTAssertNotNil(error)
                    
                    expectation.fulfill()
                }
            })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
