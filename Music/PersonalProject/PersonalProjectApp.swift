//
//  PersonalProjectApp.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 03/11/23.
//

import SwiftUI
import AVFAudio

@main
struct PersonalProjectApp: App {
    @StateObject var player: Player = Player()
    @State var volume: Float = 1.0
    
    var body: some Scene {
        WindowGroup {
            ContentView(volume: $volume)
                .environmentObject(player)
                .tint(.red)
        }
    }
}
