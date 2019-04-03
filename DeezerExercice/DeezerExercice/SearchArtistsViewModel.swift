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
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, selectedArtistValueChanged selectedArtist: Artist)
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, errorMessageValueChanged errorMessage: String)

}

@objc protocol SearchArtistsViewModelProtocol {
    
    // MARK: - Properties
    var artists: [Artist]? { get }
    var errorMessage: String? { get }
    var selectedArtist: Artist? { get }
    
    var delegate: SearchArtistsViewModelDelegate? { get set }

    // MARK: - Methods
    func searchArtists(withQuery query: String)
    func artistCellDidTapped(at indexpath: IndexPath)
}

@objcMembers final class SearchArtistsViewModel: NSObject, SearchArtistsViewModelProtocol {
    
    // MARK: - Properties
    var artists: [Artist]? {
        didSet {
            if let artists = self.artists {
                self.delegate?.searchArtistsViewModel(self, artistsValueChanged: artists)
            }
        }
    }
    
    var selectedArtist: Artist? {
        didSet {
            if let selectedArtist = self.selectedArtist {
                self.delegate?.searchArtistsViewModel(self, selectedArtistValueChanged: selectedArtist)
            }
        }
    }
    
    var errorMessage: String? {
        didSet {
            if let errorMessage = self.errorMessage {
                self.delegate?.searchArtistsViewModel(self, errorMessageValueChanged: errorMessage)
            }
        }
    }
    
    weak var delegate: SearchArtistsViewModelDelegate?
    
    // MARK: - Methods
    func searchArtists(withQuery query: String) {
        if query.isEmpty {
            self.artists = []
        } else {
            NetworkService
                .shared
                .fetchArtists(withQuery: query) { [weak self] result in
                    switch result {
                    case .success(let artists):
                        self?.artists = artists.data
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
        }
    }
    
    func artistCellDidTapped(at indexpath: IndexPath) {
        self.selectedArtist = self.artists?[indexpath.row]
    }
}
