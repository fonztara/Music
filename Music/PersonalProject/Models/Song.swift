//
//  Song.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 13/11/23.
//

import Foundation


class Song: Identifiable {
    let id = UUID()
    
    var name: String
    var audioUrl: String
    
    init(name: String, audioUrl: String) {
        self.name = name
        self.audioUrl = audioUrl
    }
}

let saoko: Song = Song(name: "Saoko", audioUrl: "saoko")
let scatole: Song = Song(name: "Scatole", audioUrl: "scatole")
let godsPlan: Song = Song(name: "God's Plan", audioUrl: "godsPlan")
