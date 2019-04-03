//
//  AlbumDetailsViewController.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//
import UIKit
import AVFoundation

final class AlbumDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = DZRColors.purple
            tableView.separatorStyle = .none
            tableView.tableFooterView = UIView()
            tableView.rowHeight = 60
            tableView.tableHeaderView?.backgroundColor = DZRColors.purple
        }
    }
    
    @IBOutlet weak var coverDZRImageView: DZRImageView! {
        didSet {
            coverDZRImageView.contentMode = .scaleAspectFill
            coverDZRImageView.clipsToBounds = true
            coverDZRImageView.alpha = 0
        }
    }
    
    @IBOutlet weak var gradientBackgroundView: UIView! {
        didSet {
            gradientBackgroundView.backgroundColor = .clear
            gradientBackgroundView.gradient(colors: [UIColor.clear, DZRColors.purple])
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            titleLabel.font = DZRFonts.largeHeavy
            titleLabel.numberOfLines = 2
            titleLabel.textColor = DZRColors.white
            titleLabel.textAlignment = .center
            titleLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var fansValueLabel: UILabel! {
        didSet {
            fansValueLabel.text = ""
            fansValueLabel.textColor = DZRColors.pink
            fansValueLabel.font = DZRFonts.medium
            fansValueLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var fansLabel: UILabel! {
        didSet {
            fansLabel.text = "Fans"
            fansLabel.textColor = DZRColors.grey.withAlphaComponent(0.5)
            fansLabel.font = DZRFonts.smallRegular
            fansLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var releaseDateValueLabel: UILabel! {
        didSet {
            releaseDateValueLabel.text = ""
            releaseDateValueLabel.textColor = DZRColors.pink
            releaseDateValueLabel.font = DZRFonts.medium
            releaseDateValueLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var releaseDateLabel: UILabel! {
        didSet {
            releaseDateLabel.text = "Release date"
            releaseDateLabel.textColor = DZRColors.grey.withAlphaComponent(0.5)
            releaseDateLabel.font = DZRFonts.smallRegular
            releaseDateLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var coverImageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setTitle("", for: .normal)
            backButton.tintColor = DZRColors.white
            backButton.setImage(DZRAssets.Icons.back, for: .normal)
        }
    }
    
    // MARK: - Properties
    @objc var artistId: Int = 0
    
    private var viewModel: AlbumDetailsViewModelProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
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
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - AlbumDetailsViewModelDelegate
extension AlbumDetailsViewController: AlbumDetailsViewModelDelegate {
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, albumValueChanged album: Album) {
        let releaseDateSplit = album.releaseDate.split(separator: "-")
        
        self.releaseDateValueLabel.text = "\(releaseDateSplit[2])/\(releaseDateSplit[1])/\(releaseDateSplit[0])"
        self.titleLabel.text = album.title.uppercased()
        self.fansValueLabel.text = String(format: "%d", locale: Locale.current, album.fans)
        
        self.viewModel?.loadTracks(withAlbumId: album.identifier)
        self.coverDZRImageView.loadAsync(withStringUrl: album.coverBig) { [weak self] in
            UIView.animate(withDuration: 0.2, animations: {
                self?.coverDZRImageView.alpha = 1
                
                self?.view.layoutIfNeeded()
            })
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.titleLabel.alpha = 1
            self.fansValueLabel.alpha = 1
            self.fansLabel.alpha = 1
            self.releaseDateValueLabel.alpha = 1
            self.releaseDateLabel.alpha = 1
            
            self.view.layoutIfNeeded()
        })
    }
    
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, tracksValueChanged tracks: [String : [Track]]) {
        self.tableView.reloadData()
    }
    
    func albumDetailsViewModel(_ albumDetailsViewModel: AlbumDetailsViewModel, playingValueChanged track: Track?) {
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
            let selectedTrack = viewModel.tracks?["\(indexPath.section+1)"]?[indexPath.row]
        else { return UITableViewCell() }

        let playingTrack = self.viewModel?.playingTrack
        
        cell.display(
            trackPosition: "\(selectedTrack.trackPosition)",
            title: selectedTrack.title,
            duration: "\((selectedTrack.duration % 3600) / 60)m \((selectedTrack.duration % 3600) % 60)s",
            isHighlight: selectedTrack.identifier == playingTrack?.identifier
        )
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AlbumDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.trackCellDidTapped(at: indexPath)
    }
}
