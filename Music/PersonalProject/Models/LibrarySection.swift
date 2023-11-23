//
//  LibrarySection.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 16/11/23.
//

import SwiftUI

struct LibrarySection: Identifiable {
    let id = UUID()
    
    var text: String
    var symbolString: String
}

let librarySections: [LibrarySection] = [
    LibrarySection(text: "Playlists", symbolString: "music.note.list"),
    LibrarySection(text: "Artists", symbolString: "music.mic"),
    LibrarySection(text: "Albums", symbolString: "square.stack"),
    LibrarySection(text: "Songs", symbolString: "music.note")
]
