//
//  AlbumDetailsViewController.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import UIKit

final class AlbumDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = DZRColors.purple
            tableView.separatorStyle = .none
            tableView.tableFooterView = UIView()
            tableView.rowHeight = 60
        }
    }
    
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
            coverImageView.contentMode = .scaleAspectFill
            coverImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var gradientBackgroundView: UIView! {
        didSet {
            gradientBackgroundView.backgroundColor = .clear
            gradientBackgroundView.gradient(colors: [UIColor.clear.cgColor, DZRColors.purple.cgColor])
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
            titleLabel.numberOfLines = 2
            titleLabel.textColor = DZRColors.white
            titleLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var fansValueLabel: UILabel! {
        didSet {
            fansValueLabel.text = ""
            fansValueLabel.textColor = DZRColors.pink
            fansValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        }
    }
    
    @IBOutlet weak var fansLabel: UILabel! {
        didSet {
            fansLabel.text = "Fans"
            fansLabel.textColor = DZRColors.grey.withAlphaComponent(0.5)
            fansLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    
    @IBOutlet weak var releaseDateValueLabel: UILabel! {
        didSet {
            releaseDateValueLabel.text = ""
            releaseDateValueLabel.textColor = DZRColors.pink
            releaseDateValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        }
    }
    
    @IBOutlet weak var releaseDateLabel: UILabel! {
        didSet {
            releaseDateLabel.text = "Release date"
            releaseDateLabel.textColor = DZRColors.grey.withAlphaComponent(0.5)
            releaseDateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    
    @IBOutlet weak var coverImageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setTitle("", for: .normal)
            backButton.tintColor = DZRColors.white
            backButton.setImage(UIImage(named: "iconBack"), for: .normal)
        }
    }

    // MARK: - Properties
    @objc var artistId: Int = 0
    
    private var viewModel: AlbumDetailsViewModelProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        self.viewModel = AlbumDetailsViewModel()
        
        self.viewModel?.loadAlbum(withArtistId: artistId)
        self.viewModel?.delegate = self
        
        self.coverImageViewTopConstraint.constant = -UIApplication.shared.statusBarFrame.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - AlbumDetailsViewModelDelegate
extension AlbumDetailsViewController: AlbumDetailsViewModelDelegate {
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, albumValueChanged album: Album) {
        self.titleLabel.text = album.title.uppercased()
        self.fansValueLabel.text = String(format: "%d", locale: Locale.current, album.fans)
        
        let releaseDateSplit = album.releaseDate.split(separator: "-")
        self.releaseDateValueLabel.text = "\(releaseDateSplit[2])/\(releaseDateSplit[1])/\(releaseDateSplit[0])"
        
        URLSession.shared.dataTask(with: URL(string:album.coverBig)!, completionHandler: { (data, response, error) in
            if error != nil { return }
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    self.coverImageView.image = downloadedImage
                }
            }
        }).resume()
        
        viewModel?.loadTracks(withAlbumId: album.identifier)
    }
    
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, tracksValueChanged tracks: [String : [Track]]) {
        self.tableView.reloadData()
    }
    
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, errorMessageValueChanged errorMessage: String) {
        self.showAlertError(message: errorMessage)
    }
}

// MARK: - UITableViewDataSource
extension AlbumDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.tracks?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.tracks?["\(section+1)"]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CD \(section+1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrackCell.self)", for: indexPath) as? TrackCell,
            let viewModel = self.viewModel,
            let track = viewModel.tracks?["\(indexPath.section+1)"]?[indexPath.row]
        else { return UITableViewCell() }

        cell.selectionStyle = .none
        
        cell.display(trackPosition: "\(track.trackPosition)", title: track.title, duration: "\((track.duration % 3600) / 60)m \((track.duration % 3600) % 60)s")
        
        return cell
    }
}
