//
//  AlbumDetailsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

protocol AlbumDetailsViewModelProtocol {
    
    //TODO : remove dynamic and use delegate
    
    // MARK: - Properties
    var album: Dynamic<Album> { get }
    var tracks: Dynamic<[String:[Track]]> { get }
    var error: Dynamic<String> { get }
    
    // MARK: - Methods
    func loadAlbum(withArtistId id: Int)
    func loadTracks(withAlbumId id: Int)
}

class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {
    
    // MARK: - Properties
    var album = Dynamic<Album>(nil)
    var tracks = Dynamic<[String:[Track]]>([:])
    var error = Dynamic<String>("")
    
    // MARK: - Methods
    func loadAlbum(withArtistId id: Int) {
        NetworkService
            .shared
            .fetchAlbums(withArtistId: id) { result in
                switch result {
                case .success(let albums):
                    self.album.value = albums.data.first
                case .failure(let error):
                    self.error.value = error.localizedDescription
                }
            }
    }
    
    func loadTracks(withAlbumId id: Int) {
        NetworkService
            .shared
            .fetchTracks(withAlbumId: id) { result in
                switch result {
                case .success(let tracks):
                    var newTracks: [String:[Track]] = [:]
                    
                    //TODO refactor this
                    
                    tracks.data.forEach {
                        newTracks["\($0.diskNumber)"] = []
                    }
                    
                    tracks.data.forEach {
                        newTracks["\($0.diskNumber)"]?.append($0)
                    }
                                        
                    self.tracks.value = newTracks
                case .failure(let error):
                    self.error.value = error.localizedDescription
                }
            }
    }
}
