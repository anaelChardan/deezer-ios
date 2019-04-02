//
//  Repository.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

protocol HasRepository {
    
    // MARK: - Properties -
    var repository: Repository { get }
}

protocol Repository {
    
    // MARK: - Methods
    func fetchAlbums(withArtistId id: Int, completion: @escaping (Result<AlbumList>) -> Void)
    func fetchTracks(withAlbumId id: Int, completion: @escaping (Result<TrackList>) -> Void)
}
