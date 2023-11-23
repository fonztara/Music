//
//  PlayerView.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 13/11/23.
//

import SwiftUI
import AVFAudio

struct PlayerView: View {
    @EnvironmentObject var player: Player
    @Binding var isExpanded: Bool
    
    var body: some View {
        HStack {
            
            HStack {
                Image("\(player.currentSong?.album.coverUrl ?? "songPlaceholder")")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .aspectRatio(1.0, contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .accessibilityHidden(true)
                
                Text("\(player.currentSong?.song.name ?? "Not playing")")
                    .font(.callout)
            }
            .accessibilityLabel("\(player.currentSong?.song.name ?? "No song") \(player.currentSong?.artist.name ?? "") playing")
            .accessibilityHint("Double tap to expand the player")
            
            Spacer()
            
            
            HStack(spacing: 16) {
                //                Button(action: {
                //                    player.backwardSong()
                //                }, label: {
                //                    Image(systemName: "backward.fill")
                //                }).buttonStyle(.plain)
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if player.isPlaying {
                            player.pausePlayer()
                        } else {
                            if (player.currentSong == nil) {
                                player.setupPlayer()
                            }
                            player.playAudio()
                        }
                    }
                }, label: {
                    Image(systemName: "\(player.isPlaying ? "pause.fill" : "play.fill")")
                }).buttonStyle(.plain)
                
                Button(action: {
                    player.forwardSong()
                }, label: {
                    Image(systemName: "forward.fill")
                }).buttonStyle(.plain)
            }.padding(.horizontal, 4)
            
            
            
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(content: {
            Rectangle()
                .foregroundStyle(.thinMaterial)
            //                .overlay(Divider().background(.gray), alignment: .bottom)
        })
        .onAppear {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay, .mixWithOthers])
            } catch {
                print("Error")
            }
        }
        .onTapGesture {
            isExpanded = true
        }
    }
    
    
}

//#Preview {
//    PlayerView()
//}
