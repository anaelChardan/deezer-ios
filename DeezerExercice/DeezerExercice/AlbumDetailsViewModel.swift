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
    
    //MARK : - Methods -
    func loadAlbum()
    func loadTracks()
}

class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {
    
    //MARK : - Properties -
    var album = Dynamic<Album>(nil)
    var tracks = Dynamic<[Track]>([])
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
    
    //MARK : - Methods -
    func loadAlbum() {
        self.dependencies
            .repository
            .fetchAlbums(withArtistId: 27) { result in
                switch result {
                case .success(let albums):
                    self.album.value = albums.data.first
                case .failure(let error):
                    break
                }
            }
    }
    
    func loadTracks() {
        
    }
}
