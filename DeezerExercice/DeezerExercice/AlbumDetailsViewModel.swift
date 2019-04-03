//
//  AlbumDetailsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

//[
//    [1: DeezerExercice.Track(identifier: 139566407, title: "Lazarus", trackPosition: 1, duration: 384, diskNumber: 1)],
//    [1: DeezerExercice.Track(identifier: 139566409, title: "No Plan", trackPosition: 2, duration: 220, diskNumber: 1)],
//    [1: DeezerExercice.Track(identifier: 139566411, title: "Killing a Little Time", trackPosition: 3, duration: 226, diskNumber: 1)],
//    [1: DeezerExercice.Track(identifier: 139566413, title: "When I Met You", trackPosition: 4, duration: 248, diskNumber: 1)]
//]
//
//[
//    "1": [
//        DeezerExercice.Track(identifier: 139566407, title: "Lazarus", trackPosition: 1, duration: 384, diskNumber: 1),
//        DeezerExercice.Track(identifier: 139566407, title: "Lazarus", trackPosition: 1, duration: 384, diskNumber: 1),
//    ],
//    "2": [
//        DeezerExercice.Track(identifier: 139566407, title: "Lazarus", trackPosition: 1, duration: 384, diskNumber: 1),
//        DeezerExercice.Track(identifier: 139566407, title: "Lazarus", trackPosition: 1, duration: 384, diskNumber: 1),
//    ]
//]

protocol AlbumDetailsViewModelProtocol {
    
    //MARK : - Properties -
    var album: Dynamic<Album> { get }
    var tracks: Dynamic<[String:[Track]]> { get }
    var error: Dynamic<String> { get }
    
    //MARK : - Methods -
    func loadAlbum(withArtistId id: Int)
    func loadTracks(withAlbumId id: Int)
}

class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {
    
    //MARK : - Properties -
    var album = Dynamic<Album>(nil)
    var tracks = Dynamic<[String:[Track]]>([:])
    var error = Dynamic<String>("")
    
    //MARK : - Methods -
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
