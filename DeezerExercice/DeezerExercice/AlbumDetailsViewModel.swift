//
//  AlbumDetailsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

protocol AlbumDetailsViewModelDelegate: class {
    
    /**
     Update view with the new album data.
     
     - parameters:
        - albumDetailsViewModel: The view model that update the value.
        - album: Album that has been updated.
     */
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, albumValueChanged album: Album)
    
    /**
     Update view with the new tracks data.
     
     - parameters:
        - albumDetailsViewModel: The view model that update the value.
        - tracks: Tracks that has been updated.
     */
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, tracksValueChanged tracks: [String:[Track]])
    
    /**
     Update view with the new playing music data.
     
     - parameters:
        - albumDetailsViewModel: The view model that update the value.
        - track: Playing music that has been updated.
     */
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, playingValueChanged track: Track?)
    
    /**
     Update view with the new error message.
     
     - parameters:
        - albumDetailsViewModel: The view model that update the value.
        - errorMessage: Error message that has been updated.
     */
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, errorMessageValueChanged errorMessage: String)
    
}

protocol AlbumDetailsViewModelProtocol: class {
    
    // MARK: - Properties
    
    /**
     Album shown.
     */
    var album: Album? { get }
    
    /**
     All tracks of the current shown album.
     */
    var tracks: [String: [Track]]? { get }
    
    /**
     Current playing track. Nil if there is no one.
     */
    var playingTrack: Track? { get }
    
    /**
     Message shown to the use in case of error.
     */
    var errorMessage: String? { get }
    
    var delegate: AlbumDetailsViewModelDelegate? { get set }
    
    // MARK: - Methods
    
    /**
     Fetch albums with a given artist id from Deezer API.
     
     - parameters:
     - id: The artist's identifier.
     */
    func loadAlbum(withArtistId id: Int)
    
    /**
     Fetch tracks with a given album id from Deezer API.
     
     - parameters:
     - id: The album's identifier.
     */
    func loadTracks(withAlbumId id: Int)
    
    /**
     Play or stop the music at a given indexPath.
     
     - parameters:
     - indexPath: Identify the music.
     */
    func trackCellDidTapped(at indexPath: IndexPath)
}

final class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {
    
    // MARK: - Properties
    var album: Album? {
        didSet {
            if let album = self.album {
                self.delegate?.albumDetailsViewModel(self, albumValueChanged: album)
            }
        }
    }
    
    var tracks: [String: [Track]]? {
        didSet {
            if let tracks = self.tracks {
                self.delegate?.albumDetailsViewModel(self, tracksValueChanged: tracks)
            }
        }
    }
    
    var playingTrack: Track? {
        didSet {
            self.delegate?.albumDetailsViewModel(self, playingValueChanged: playingTrack)
        }
    }
    
    var errorMessage: String? {
        didSet {
            if let errorMessage = self.errorMessage {
                self.delegate?.albumDetailsViewModel(self, errorMessageValueChanged: errorMessage)
            }
        }
    }
    
    weak var delegate: AlbumDetailsViewModelDelegate?
    
    // MARK: - Methods
    func loadAlbum(withArtistId id: Int) {
        NetworkService
            .shared
            .fetchAlbums(withArtistId: id) { [weak self] result in
                switch result {
                case .success(let albums):
                    self?.album = albums.data.first
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
    }
    
    func loadTracks(withAlbumId id: Int) {
        NetworkService
            .shared
            .fetchTracks(withAlbumId: id) { [weak self] result in
                switch result {
                case .success(let tracks):
                    var newTracks: [String:[Track]] = [:]
                                        
                    tracks.data.forEach {
                        newTracks["\($0.diskNumber)"] = []
                    }
                    
                    tracks.data.forEach {
                        newTracks["\($0.diskNumber)"]?.append($0)
                    }
                    
                    self?.tracks = newTracks
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
    }
    
    func trackCellDidTapped(at indexPath: IndexPath) {
        guard let playingTrack = self.tracks?["\(indexPath.section+1)"]?[indexPath.row] else { return }
        
        //If a track is playing, pause it
        if self.playingTrack?.identifier == playingTrack.identifier {
            PlayerService
                .shared
                .pause()
            self.playingTrack = nil
        }
        //No track playing, so play it
        else {
            PlayerService
                .shared
                .play(withStringUrl: playingTrack.previewUrl)
            self.playingTrack = playingTrack
        }
    }
}
