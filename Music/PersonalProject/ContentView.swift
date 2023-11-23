//
//  ContentView.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 03/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var player: Player
    @State private var selection = 1
    @State var isExpanded: Bool = false
    
    @Binding var volume: Float
    
    var body: some View {
        TabView(selection: $selection) {
            BrowseView()
                .tabItem({
                    Label("Browse", systemImage: "square.grid.2x2.fill")
                })
                .tag(1)
            LibraryView()
                .tabItem({
                    Label("Library", systemImage: "music.quarternote.3")
                })
                .tag(2)
            SearchView()
                .tabItem({
                    Label("Search", systemImage: "magnifyingglass")
                })
                .tag(3)
        }
        .overlay(alignment: .bottom, content: {
            PlayerView(isExpanded: $isExpanded)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                .padding(.bottom, 56)
                .padding(.horizontal, 8)
        })
        .sheet(isPresented: $isExpanded, onDismiss: {isExpanded = false}, content: {
            ExpandedPlayerView(isExpanded: $isExpanded, volume: $volume)
                .presentationDragIndicator(.visible)
//                .presentationDetents([.large])
                .presentationCompactAdaptation(.fullScreenCover)
                .presentationBackground(.regularMaterial)
        })
    }
}

//#Preview {
//    ContentView()
//}
