//
//  BrowseView.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 14/11/23.
//

import SwiftUI

struct BrowseView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(sampleArtists) { artist in
                        Section(content: {
                            ScrollView(.horizontal) {
                                HStack(spacing: 16) {
                                    ForEach(artist.albums) { album in
                                        NavigationLink(destination: {
                                            AlbumDetailView(album: album, artist: artist)
                                        }, label: {
                                            VStack(alignment: .leading) {
                                                Image(album.coverUrl)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 150, height: 150)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                                    .shadow(color: .gray, radius: 0.5)
                                                Text(album.title)
                                                    .foregroundStyle(Color.primary)
                                                    .font(.footnote)
                                            }
                                        })
                                        .accessibilityLabel("\(album.title)")
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                                .padding(.top, 4)
                            }
                            .scrollIndicators(.hidden)
                        }, header: {
                            HStack {
                                Text(artist.name)
                                    .font(.title3)
                                    .bold()
                                    .padding(.horizontal)
                                    .padding(.top)
                                Spacer()
                            }
                            .accessibilityLabel("Artist \(artist.name)")
                        })
                    }
                }
                .padding(.bottom, 64)
            }.navigationTitle("Browse")
        }
    }
}

#Preview {
    BrowseView()
}
