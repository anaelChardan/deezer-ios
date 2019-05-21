//
//  NetworkService.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

protocol NetworkServiceProtocol: class {
    
    /**
     Fetch albums with a given artist id in background thread from Deezer API.
     
     - parameters:
     - id: The artist's identifier.
     - completion: Code executed in case of success or failure in the main thread.
     */
    func fetchAlbums(withArtistId id: Int, completion: @escaping (Result<AlbumList, DZRError>) -> Void)
    
    /**
     Fetch tracks with a given album id from Deezer API.
     
     - parameters:
     - id: The album's identifier.
     - completion: Code executed in case of success or failure in the main thread.
     */
    func fetchTracks(withAlbumId id: Int, completion: @escaping (Result<TrackList, DZRError>) -> Void)
    
    /**
     Fetch artists with a given query from Deezer API.
     
     - parameters:
     - query: Text that is use to search an artist by his name.
     - completion: Code executed in case of success or failure in the main thread.
     */
    func fetchArtists(withQuery query: String, completion: @escaping (Result<ArtistList, DZRError>) -> Void)
    
}

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    static let shared: NetworkServiceProtocol = NetworkService()
    
    // MARK: - Methods
    private func request<T>(with stringUrl: String, completion: @escaping (Result<T, DZRError>) -> Void) where T: Codable {
        guard let url = URL(string: stringUrl) else {
            completion(.failure(DZRError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error!))) }
                return
            }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(objects)) }
            } catch let error {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error))) }
            }
        }.resume()
    }
    
    func fetchAlbums(withArtistId id: Int, completion: @escaping (Result<AlbumList, DZRError>) -> Void) {
        request(with: "https://api.deezer.com/artist/\(id)/albums", completion: completion)
    }
    
    func fetchTracks(withAlbumId id: Int, completion: @escaping (Result<TrackList, DZRError>) -> Void) {
        request(with: "https://api.deezer.com/album/\(id)/tracks", completion: completion)
    }
    
    func fetchArtists(withQuery query: String, completion: @escaping (Result<ArtistList, DZRError>) -> Void) {
        guard let stringUrl = "http://api.deezer.com/search/artist?q=\(query)&limit=150".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        request(with: stringUrl, completion: completion)
    }
}
