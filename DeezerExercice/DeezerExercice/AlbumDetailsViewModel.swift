//
//  AlbumDetailsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

protocol AlbumDetailsViewModelProtocol {
    
    //MARK : - Properties -
    var title: Dynamic<String> { get }
    var tracks: Dynamic<[Track]> { get }
    
    //MARK : - Methods -
    func loadAlbumDetails()
    func loadTracks()
}

class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {
    
    //MARK : - Properties -
    var title = Dynamic<String>("")
    var tracks = Dynamic<[Track]>([])
    
    //MARK : - Methods -
    func loadAlbumDetails() {
        self.title.value = "Title"
    }
    
    func loadTracks() {
        
    }
}
