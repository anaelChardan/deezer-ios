//
//  AlbumDetailsViewController.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    //MARK : - Outlets -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK : - Properties -
    @objc var artistId: Int = 0
    
    private var viewModel: AlbumDetailsViewModelProtocol? {
        didSet {
            guard let viewModel = self.viewModel else { return }

            viewModel.album.bind {
                self.title = $0.title
                
                viewModel.loadTracks(withAlbumId: $0.identifier)
            }
            
            viewModel.tracks.bind { _ in
                self.tableView.reloadData()
            }
            
            viewModel.error.bind {
                self.showAlertError(message: $0)
            }
        }
    }
    
    //MARK : - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        self.viewModel = AlbumDetailsViewModel()

        self.viewModel?.loadAlbum(withArtistId: artistId)
    }
}

extension AlbumDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.tracks.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrackCell.self)", for: indexPath) as? TrackCell,
            let viewModel = self.viewModel,
            let track = viewModel.tracks.value?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.display(title: track.title)
        
        return cell
    }
}
