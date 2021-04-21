//
//  SoundManager.swift
//  GameChallenge
//
//  Created by Mateus Nobre on 08/04/21.
//

import Foundation
import AVKit

enum SceneSong {
    case mainMenu
    case gamePlay
}

class SongsManager {

    static let shared = SongsManager()
    var soundPlayer: AVAudioPlayer = AVAudioPlayer()
    let mainSoundUrl = Bundle.main.url(forResource: "background_jogo2", withExtension: "mp3")!
    let gamePlaySoundUrl = Bundle.main.url(forResource: "gameplay_background", withExtension: "mp3")!

    func setCurrentSong(sceneSong: SceneSong) {
        switch sceneSong {
        case .mainMenu:
            do {
                try soundPlayer = AVAudioPlayer(contentsOf: mainSoundUrl)
            } catch {
                return
            }
        case .gamePlay:
            do {
                try soundPlayer = AVAudioPlayer(contentsOf: gamePlaySoundUrl)
            } catch {
                return
            }
        }
    }

    func playSong(startPoint: TimeInterval = 0) {
        soundPlayer.currentTime = startPoint
        soundPlayer.play()
        soundPlayer.setVolume(1, fadeDuration: 0.5)
    }

    func pauseSong() {
        soundPlayer.setVolume(0, fadeDuration: 0.5)
        //soundPlayer.pause()
    }

    func setVolume(to newVolume: Float, fadeDuration: TimeInterval) {
        soundPlayer.setVolume(newVolume, fadeDuration: fadeDuration)
    }
}
