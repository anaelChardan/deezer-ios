//
//  NetworkService.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

protocol NetworkServiceProtocol: class {
    
    func fetchAlbums(withArtistId id: Int, completion: @escaping (Result<AlbumList, DZRError>) -> Void)
    func fetchTracks(withAlbumId id: Int, completion: @escaping (Result<TrackList, DZRError>) -> Void)
    func fetchArtists(withQuery query: String, completion: @escaping (Result<ArtistList, DZRError>) -> Void)
    
}

final class NetworkService: NSObject, NetworkServiceProtocol {
    
    // MARK: - Properties
    static let shared: NetworkServiceProtocol = NetworkService()
    
    // MARK: - Methods
    func fetchAlbums(withArtistId id: Int, completion: @escaping (Result<AlbumList, DZRError>) -> Void) {
        guard let url = URL(string: "https://api.deezer.com/artist/\(id)/albums") else {
            completion(.failure(DZRError.invalidURL))
            return
        }
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error!))) }
                return
            }
            
            do {
                let albums = try JSONDecoder().decode(AlbumList.self, from: data)
                DispatchQueue.main.async { completion(.success(albums)) }
            } catch let error {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error))) }
            }
        }.resume()
    }
    
    func fetchTracks(withAlbumId id: Int, completion: @escaping (Result<TrackList, DZRError>) -> Void) {
        guard let url = URL(string: "https://api.deezer.com/album/\(id)/tracks") else {
            completion(.failure(DZRError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error!))) }
                return
            }
            
            do {
                let tracks = try JSONDecoder().decode(TrackList.self, from: data)
                DispatchQueue.main.async { completion(.success(tracks)) }
            } catch let error {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error))) }
            }
        }.resume()
    }
    
    func fetchArtists(withQuery query: String, completion: @escaping (Result<ArtistList, DZRError>) -> Void) {
        guard
            let stringUrl = "http://api.deezer.com/search/artist?q=\(query)&limit=150".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: stringUrl)
        else {
            completion(.failure(DZRError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error!))) }
                return
            }
            
            do {
                let artists = try JSONDecoder().decode(ArtistList.self, from: data)
                DispatchQueue.main.async { completion(.success(artists)) }
            } catch let error {
                DispatchQueue.main.async { completion(.failure(DZRError.error(error))) }
            }
        }.resume()
    }
}