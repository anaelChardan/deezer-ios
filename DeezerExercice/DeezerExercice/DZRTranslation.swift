//
//  DZRTranslation.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 05/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import Foundation

@objcMembers class DZRTranslation: NSObject {
    
    // MARK: - Default
    static let defaultError = NSLocalizedString("default_error", comment: "")
    static let defaultOk = NSLocalizedString("default_ok", comment: "")
    
    // MARK: - Album detail
    static let albumDetailFans = NSLocalizedString("album_detail_fans", comment: "")
    static let albumDetailReleaseDate = NSLocalizedString("album_detail_release_date", comment: "")
    
    // MARK: - Search artists
    static let searchArtistsSearchBarPlaceholder = NSLocalizedString("search_artists_searchbar_placeholder", comment: "") //Enter an artist name
    static let searchArtistsInformationSearchEmpty = NSLocalizedString("search_artists_information_search_empty", comment: "") //Search an artist. For example U2, Queen, Muse ...
    static let searchArtistsInformationSearchNoResult = NSLocalizedString("search_artists_information_search_no_result", comment: "") //Your search returned no results, try another name
    static let searchArtistsButtonSearch = NSLocalizedString("search_artists_button_search", comment: "") //Search !
    static let searchArtistsPopularsHeaderTitle = NSLocalizedString("search_artists_populars_header_title", comment: "") //Populars
    static let searchArtistsOthersHeaderTitle = NSLocalizedString("search_artists_others_header_title", comment: "") //Others
}
