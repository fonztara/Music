//
//  Player.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 13/11/23.
//

import Foundation
import AVFAudio

class Player: ObservableObject {
    @Published var history: [SongInfo] = []
    
    @Published var currentSong: SongInfo? = nil
    
    @Published var totalTime: TimeInterval = 0.0
    
    @Published var queue: [SongInfo] = []
    
    @Published var audioPlayer: AVAudioPlayer? = AVAudioPlayer()
    
    @Published var isPlaying: Bool = false
    
    
    
    init(history: [SongInfo] = [], currentSong: SongInfo? = nil, totalTime: TimeInterval = 0.0, queue: [SongInfo] = [], audioPlayer: AVAudioPlayer? = AVAudioPlayer(), isPlaying: Bool = false) {
        self.history = history
        self.currentSong = currentSong
        self.totalTime = totalTime
        self.queue = queue
        self.audioPlayer = audioPlayer
        self.isPlaying = isPlaying
    }
    
    
    
    
    //MARK: FUNCTIONS
    
    func setCurrentSong(songInfo: SongInfo) {
        self.currentSong = songInfo
    }
    
    func setupPlayer() {
        
        if( self.currentSong == nil ) {
            self.currentSong = SongInfo(song: saoko, artist: rosalia, album: motomami)
        }
        
        let url = Bundle.main.url(forResource: self.currentSong?.song.audioUrl, withExtension: "mp3")
        self.audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        self.audioPlayer?.prepareToPlay()
        self.totalTime = self.audioPlayer?.duration ?? 0.0
    }
    
    func playAudio() {
        if( self.currentSong == nil ) {
            self.currentSong = SongInfo(song: saoko, artist: rosalia, album: motomami)
        }
        self.isPlaying = true
        self.audioPlayer?.play()
    }
    
    func updateCurrentTime(currentTime: TimeInterval) {
        audioPlayer?.currentTime = currentTime
        
        if currentTime >= totalTime {
            forwardSong()
            audioPlayer?.currentTime = 0.0
        }
    }
    
    func setVolume(volume: Float) {
        audioPlayer?.setVolume(volume, fadeDuration: 1.0)
    }
    
    func pausePlayer() {
        self.isPlaying = false
        
        if( self.currentSong == nil ) {
        } else {
            self.audioPlayer?.stop()
        }
    }
    
    func forwardSong() {
        if self.queue.isEmpty {
            
        } else {
            self.history.append(self.currentSong!)
            pausePlayer()
            setCurrentSong(songInfo: queue[0])
            setupPlayer()
            playAudio()
            self.queue.removeFirst()
        }
    }
    
    func backwardSong() {
        if self.history.isEmpty {
            
        } else {
            self.queue.insert(self.currentSong!, at: 0)
            pausePlayer()
            setCurrentSong(songInfo: history[history.endIndex - 1])
            setupPlayer()
            playAudio()
            self.history.removeLast()
        }
    }
    
    
    
    
    
    func addSongToQueue(songInfo: SongInfo) {
        self.queue.append(songInfo)
    }
    
    func addSongToHistory(songInfo: SongInfo) {
        self.history.append(songInfo)
    }
    
    func emptyQueue() {
        self.queue.removeAll()
    }
    
    func emptyHistory() {
        self.history.removeAll()
    }
}
