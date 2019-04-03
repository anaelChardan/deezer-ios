//
//  SearchArtistsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

@objc protocol SearchArtistsViewModelDelegate {
    
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, artistsValueChanged artists: [Artist])
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, errorMessageValueChanged errorMessage: String)
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, selectedArtistValueChanged selectedArtist: Artist)
    
}

@objc protocol SearchArtistsViewModelProtocol: class {
    
    //MARK : - Properties -
    var artists: [Artist] { get }
    var errorMessage: String { get }
    var selectedArtist: Artist? { get }
    
    weak var delegate: SearchArtistsViewModelDelegate? { get set }

    //MARK : - Methods -
    func searchArtists(withQuery query: String)
    func artistCellDidTapped(at indexpath: IndexPath)
}

@objcMembers class SearchArtistsViewModel: NSObject, SearchArtistsViewModelProtocol {
    
    // MARK: - Properties
    var artists = [Artist]() {
        didSet {
            self.delegate?.searchArtistsViewModel(self, artistsValueChanged: self.artists)
        }
    }
    
    var errorMessage = "" {
        didSet {
            self.delegate?.searchArtistsViewModel(self, errorMessageValueChanged: self.errorMessage)
        }
    }
    
    var selectedArtist: Artist? {
        didSet {
            if let selectedArtist = self.selectedArtist {
                self.delegate?.searchArtistsViewModel(self, selectedArtistValueChanged: selectedArtist)
            }
        }
    }
    
    weak var delegate: SearchArtistsViewModelDelegate?
    
    // MARK: - Methods
    func searchArtists(withQuery query: String) {
        NetworkService
            .shared
            .fetchAlbums(withArtistId: 1) { (result) in
                self.delegate?.searchArtistsViewModel(self, artistsValueChanged: [])
            }
        
        NetworkService
            .shared
            .fetchArtists(withQuery: query) { result in
                switch result {
                case .success(let artists):
                    self.artists = artists.data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
    }
    
    func artistCellDidTapped(at indexpath: IndexPath) {
        self.selectedArtist = self.artists[indexpath.row]
    }
}
