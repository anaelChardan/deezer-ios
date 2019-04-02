//
//  AlbumDetailsViewController.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    //MARK : - Properties -
    @objc var artistId: Int = 0
    
    private var viewModel: AlbumDetailsViewModelProtocol? {
        didSet {
            guard let viewModel = self.viewModel else { return }

            viewModel.album.bind {
                self.title = $0.title
                
                viewModel.loadTracks(withAlbumId: $0.identifier)
            }
            
            viewModel.tracks.bind {
                print($0.count)
            }
            
            viewModel.error.bind {
                self.showAlertError(message: $0)
            }
        }
    }
    
    //MARK : - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AlbumDetailsViewModel()

        self.viewModel?.loadAlbum(withArtistId: artistId)
    }
}
