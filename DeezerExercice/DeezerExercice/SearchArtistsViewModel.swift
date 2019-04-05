//
//  SearchArtistsViewModel.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

@objc protocol SearchArtistsViewModelDelegate {
    
    /**
     Update view with the new artists data.
     
     - parameters:
        - searchArtistsViewModel: The view model that update the value.
        - artists: Artists that has been updated.
     */
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, artistsValueChanged artists: [String: [Artist]])
    
    /**
     Update view with the selected artist data.
     
     - parameters:
        - searchArtistsViewModel: The view model that update the value.
        - selectedArtist: Selected artist that has been updated.
     */
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, selectedArtistValueChanged selectedArtist: Artist)
    
    /**
     Update view with the new error message.
     
     - parameters:
        - searchArtistsViewModel: The view model that update the value.
        - errorMessage: Error message that has been updated.
     */
    func searchArtistsViewModel(_ searchArtistsViewModel: SearchArtistsViewModel, errorMessageValueChanged errorMessage: String)

}

@objc protocol SearchArtistsViewModelProtocol {
    
    // MARK: - Properties
    
    /**
     Artists shown.
     */
    var artists: [String: [Artist]]? { get }
  
    /**
     Artist selected by the user with a tap on the artist's cell.
     */
    var selectedArtist: Artist? { get }
    
    /**
     Message shown to the use in case of error.
     */
    var errorMessage: String? { get }
    
    /**
     Last query executed to the remote server.
     */
    var lastQueryString: String { get }
    
    var delegate: SearchArtistsViewModelDelegate? { get set }

    // MARK: - Methods
    
    /**
     Fetch artists with a given query from Deezer API.
     
     - parameters:
        - query: Text that is use to search an artist by his name.
     */
    func searchArtists(withQuery query: String)
    
    /**
     Change the selected artist by the new one, depending on the cell position.
     
     - parameters:
        - indexPath: IndexPath of the tapped cell.
     */
    func artistCellDidTapped(at indexpath: IndexPath)
    
    /**
     Give the key of the section to the data.
     
     - returns:
     The key string.
     
     - parameters:
        - section: Section number to retreive the key.
     */
    func sectionName(with section: Int) -> String
}

@objcMembers final class SearchArtistsViewModel: NSObject, SearchArtistsViewModelProtocol {
    
    // MARK: - Properties
    var artists: [String: [Artist]]? {
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
    
    var lastQueryString: String = ""
    
    weak var delegate: SearchArtistsViewModelDelegate?
    
    // MARK: - Methods
    func searchArtists(withQuery query: String) {
        self.lastQueryString = query
        
        //If the query is empty, return an empty artists array.
        if query.isEmpty {
            self.artists = [:]
        } else {
            NetworkService
                .shared
                .fetchArtists(withQuery: query) { [weak self] result in
                    switch result {
                    case .success(let artists):
                        var newArtists: [String: [Artist]] = [:]
                                                
                        newArtists["populars"] = []
                        newArtists["others"] = []
                        
                        artists.data.forEach { artist in
                            newArtists[artist.fans > 150000 ? "populars" : "others"]?.append(artist)
                        }
                    
                        self?.artists = newArtists
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
        }
    }
    
    func artistCellDidTapped(at indexpath: IndexPath) {
        self.selectedArtist = self.artists?[sectionName(with: indexpath.section)]?[indexpath.row]
    }
    
    func sectionName(with section: Int) -> String {
        //First section is populars artists, second one is the others.
        return section == 0 ? "populars" : "others"
    }
}
