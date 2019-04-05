//
//  PlayerService.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 03/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import AVFoundation

protocol PlayerServiceProtocol: class {
    
    // MARK: - Properties
    /**
     Is the music is playing or not.
    */
    var isPlaying: Bool { get }
    
    // MARK: - Methods
    
    /**
     Stream a song from a remote url.
     
     - parameters:
        - stringUrl: Url where the song is located online.
     */
    func play(withStringUrl stringUrl: String)
    
    /**
     Pause the playing music.
     */
    func pause()
    
}

final class PlayerService: PlayerServiceProtocol {
    
    // MARK: - Properties
    var isPlaying: Bool {
        return self.player?.rate != 0 && self.player?.error == nil
    }
    
    static let shared: PlayerServiceProtocol = PlayerService()
    
    private var player: AVPlayer?
    
    // MARK: - Methods
    func play(withStringUrl stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print(error)
        }
        
        self.player = AVPlayer(url: url)
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
}
