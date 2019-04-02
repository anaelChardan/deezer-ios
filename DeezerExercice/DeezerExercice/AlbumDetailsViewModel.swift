//
//  AlbumDetailsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

protocol AlbumDetailsViewModelProtocol {
    
    //MARK : - Properties -
    var album: Dynamic<Album> { get }
    var tracks: Dynamic<[Track]> { get }
    var error: Dynamic<String> { get }
    
    //MARK : - Methods -
    func loadAlbum(withArtistId id: Int)
    func loadTracks(withAlbumId id: Int)
}

class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {
    
    //MARK : - Properties -
    var album = Dynamic<Album>(nil)
    var tracks = Dynamic<[Track]>([])
    var error = Dynamic<String>("")
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
    
    //MARK : - Methods -
    func loadAlbum(withArtistId id: Int) {
        self.dependencies
            .repository
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
        self.dependencies
            .repository
            .fetchTracks(withAlbumId: id) { result in
                switch result {
                case .success(let tracks):
                    self.tracks.value = tracks.data
                case .failure(let error):
                    self.error.value = error.localizedDescription
                }
            }
    }
}
