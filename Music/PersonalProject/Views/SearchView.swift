//
//  SearchView.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 14/11/23.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    
    var songs: [Song] {
        var array: [Song] = []
        for artist in sampleArtists {
            for album in artist.albums {
                for song in album.songs {
                    array.append(song)
                }
            }
        }
        
        return array
    }
    
    var searchResults: [Song] {
        if searchText.isEmpty {
            return songs
        } else {
            return songs.filter { song in
                song.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { song in
                    Text(song.name)
                }
            }
        }
        .searchable(text: $searchText, prompt: "What do you want to listen to?")
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    SearchView()
}

extension String: Identifiable {
    public var id: UUID {
        return UUID()
    }
}
