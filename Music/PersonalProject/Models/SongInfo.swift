//
//  SongInfo.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 19/11/23.
//

import SwiftUI

class SongInfo: Identifiable {
    let id = UUID()
    
    var song: Song
    var artist: Artist
    var album: Album
    
    init(song: Song, artist: Artist, album: Album) {
        self.song = song
        self.artist = artist
        self.album = album
    }
}
