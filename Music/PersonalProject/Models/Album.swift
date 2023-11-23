//
//  Album.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 15/11/23.
//

import SwiftUI

class Album: Identifiable {
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



//ROSALIA
let motomami: Album = Album(title: "Motomami", coverUrl: "rosalia", songs: [saoko])
let malQuerer = Album(title: "El Mal Querer", coverUrl: "rosalia", songs: [saoko])
let losAngeles = Album(title: "Los Angeles", coverUrl: "rosalia", songs: [saoko])

//PINGUINI
let hype: Album = Album(title: "Fuori dall'Hype", coverUrl: "pinguini", songs: [scatole])
let fakeNews = Album(title: "FakeNews", coverUrl: "pinguini", songs: [scatole])
let ahia = Album(title: "Ahia!", coverUrl: "pinguini", songs: [scatole])

//DRAKE
let loverBoy: Album = Album(title: "Certified Lover Boy", coverUrl: "drake", songs: [godsPlan])
let scorpion = Album(title: "Scorpion", coverUrl: "drake", songs: [godsPlan])
let takeCare = Album(title: "Take Care", coverUrl: "drake", songs: [godsPlan])

