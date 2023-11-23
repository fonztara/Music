//
//  Playlist.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 15/11/23.
//

import SwiftUI

class Playlist: Identifiable, ObservableObject {
    let id = UUID()
    
    var title: String
    var coverUrl: String
    var songs: [Song]
    
    init(title: String, coverUrl: String, songs: [Song]) {
        self.title = title
        self.coverUrl = coverUrl
        self.songs = songs
    }
}
