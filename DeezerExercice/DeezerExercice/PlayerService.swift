//
//  PlayerService.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import AVFoundation

protocol PlayerServiceProtocol: class {
    
    func play(withStringUrl stringUrl: String)
    func pause()
    
}

final class PlayerService: PlayerServiceProtocol {
    
    // MARK: - Properties
    static let shared: PlayerServiceProtocol = PlayerService()
    
    private var player: AVPlayer?
    
    // MARK: - Methods
    func play(withStringUrl stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        
        self.player = AVPlayer(url: url)
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
}
