//
//  Artist.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 15/11/23.
//

import SwiftUI

class Artist: Identifiable {
    let id = UUID()
    
    var name: String
    var pictureUrl: String
    var albums: [Album]
    
    init(name: String, pictureUrl: String, albums: [Album]) {
        self.name = name
        self.pictureUrl = pictureUrl
        self.albums = albums
    }
}


let rosalia: Artist = Artist(name: "ROSALIA", pictureUrl: "rosalia", albums: [motomami, malQuerer, losAngeles])

let pinguini: Artist = Artist(name: "Pinguini Tattici Nucleari", pictureUrl: "pinguini", albums: [hype, fakeNews, ahia])

let drake: Artist = Artist(name: "Drake", pictureUrl: "drake", albums: [loverBoy, scorpion, takeCare])


let sampleArtists: [Artist] = [rosalia, pinguini, drake]
