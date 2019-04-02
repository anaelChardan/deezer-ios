//
//  RemoteRepository.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import Foundation

final class RemoteRepository: Repository {
    
    func fetchAlbums(withArtistId id: Int, completion: @escaping (Result<AlbumList>) -> Void) {
        guard let url = URL(string: "https://api.deezer.com/artist/\(id)/albums") else {
            completion(.failure(DZRError.invalidURL(url: "https://api.deezer.com/artist/\(id)/albums")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(.failure(error!)) }
                return
            }
            
            guard let albums = try? JSONDecoder().decode(AlbumList.self, from: data) else {
                DispatchQueue.main.async { completion(.failure(DZRError.failedToUnwrap)) }
                return
            }
            
            DispatchQueue.main.async { completion(.success(albums)) }
        }.resume()
    }
    
    func fetchTracks(withAlbumId id: Int, completion: @escaping (Result<TrackList>) -> Void) {
        guard let url = URL(string: "https://api.deezer.com/album/\(id)/tracks") else {
            completion(.failure(DZRError.invalidURL(url: "https://api.deezer.com/album/\(id)/tracks")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(.failure(error!)) }
                return
            }
            
            guard let tracks = try? JSONDecoder().decode(TrackList.self, from: data) else {
                DispatchQueue.main.async { completion(.failure(DZRError.failedToUnwrap)) }
                return
            }
            
            DispatchQueue.main.async { completion(.success(tracks)) }
        }.resume()
    }
    
}
