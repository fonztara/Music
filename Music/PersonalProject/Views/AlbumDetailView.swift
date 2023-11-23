//
//  AlbumDetailView.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 17/11/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @EnvironmentObject var player: Player
    var album: Album
    var artist: Artist
    
    var body: some View {
        
        //TODO: LIST SECTION (ALBUM AS HEADER)
        List {
            Section(content: {
                ForEach(album.songs) { song in
                    Button(action: {
                        withAnimation(.smooth(duration: 0.1)) {
                            if(player.isPlaying) {
                                player.pausePlayer()
                            }
                            player.setCurrentSong(songInfo: SongInfo(song: song, artist: artist, album: album))
                            player.setupPlayer()
                            player.playAudio()
                        }
                        
                    }, label: {
                        Text(song.name)
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    player.addSongToQueue(songInfo: SongInfo(song: song, artist: artist, album: album))
                                } label: {
                                    Image(systemName: "text.line.last.and.arrowtriangle.forward")
                                        .tint(.orange)
                                        .accessibilityLabel("Add to queue")
                                }
                            }
                    })
                }
            }, header: {
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Image(album.coverUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .shadow(color: .gray, radius: 0.5)
                            .padding(4)
                        Text(album.title)
                            .font(.title)
                            .foregroundStyle(.primary)
                        Text(artist.name)
                            .foregroundStyle(Color.accentColor)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                
                            }, label: {
                                Label("Play", systemImage: "play.fill")
                                    .frame(width: 150)
                                    .padding(.vertical, 10)
                                    .background(content: {
                                        RoundedRectangle(cornerRadius: 8.0)
                                            .foregroundStyle(Color(UIColor.systemGray5))
                                    })
                            })
                            
                            //                    Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Label("Shuffle", systemImage: "shuffle")
                                    .frame(width: 150)
                                    .padding(.vertical, 10)
                                    .background(content: {
                                        RoundedRectangle(cornerRadius: 8.0)
                                            .foregroundStyle(Color(UIColor.systemGray5))
                                    })
                            })
                        }
                        .padding(.vertical)
                    }
                    Spacer()
                }
                .padding(.top, -70)
            })
        }
        .listStyle(.plain)
    }
}

#Preview {
    AlbumDetailView(album: motomami, artist: rosalia)
}
