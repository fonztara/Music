//
//  LibraryView.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 14/11/23.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var player: Player
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(librarySections) { section in
                        NavigationLink(destination: {
                            
                        }, label: {
                            HStack {
                                Image(systemName: section.symbolString)
                                    .foregroundStyle(Color.accentColor)
                                Text(section.text)
                            }
                        })
                    }
                }
                
                
//                ForEach(songs) { song in
//                    Button(action: {
//                        player.addSongToQueue(song: song)
//                    }, label: {
//                        Text(song.name)
//                    })
//                }
                
                
                
            }
            .navigationTitle("Library")
        }
    }
}

#Preview {
    LibraryView()
}
