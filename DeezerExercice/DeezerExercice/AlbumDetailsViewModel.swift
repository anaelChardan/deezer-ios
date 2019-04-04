//
//  AlbumDetailsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

protocol AlbumDetailsViewModelDelegate: class {
    
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, albumValueChanged album: Album)
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, tracksValueChanged tracks: [String:[Track]])
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, playingValueChanged track: Track?)
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, errorMessageValueChanged errorMessage: String)
    
}

protocol AlbumDetailsViewModelProtocol: class {
    
    // MARK: - Properties
    var album: Album? { get }
    var tracks: [String: [Track]]? { get }
    var playingTrack: Track? { get }
    var errorMessage: String? { get }
    
    var delegate: AlbumDetailsViewModelDelegate? { get set }
    
    // MARK: - Methods
    func loadAlbum(withArtistId id: Int)
    func loadTracks(withAlbumId id: Int)
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
                    
                    //TODO add comments
                    
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
