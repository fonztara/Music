//
//  ExpandedPlayerView.swift
//  PersonalProject
//
//  Created by Alfonso Tarallo on 20/11/23.
//

import SwiftUI
import AVFAudio

struct ExpandedPlayerView: View {
    @EnvironmentObject var player: Player
    @Binding var isExpanded: Bool
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var volume: Float
    
    @State var currentTime: TimeInterval = 0.0
    
    var scaleEffect: CGFloat {
        if player.isPlaying {
            return 1.3
        } else {
            return 1.1
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isExpanded = false
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.foreground)
                        .font(.title3)
                })
                .accessibilityHint("Double tap to close the player")
                
            }
            
            Image("\(player.currentSong?.album.coverUrl ?? "songPlaceholder")")
                .resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(1.0, contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .padding(64)
                .scaleEffect(x: scaleEffect, y: scaleEffect, anchor: .center)
                .accessibilityLabel("\(player.currentSong?.album.title ?? "No") album cover")
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(player.currentSong?.song.name ?? "Not playing")")
                        .font(.title3)
                        .bold()
                    Text("\(player.currentSong?.artist.name ?? "No Artist")")
                        .opacity(0.5)
                }
                .accessibilityElement(children: .contain)
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "star")
                            .font(.footnote)
                            .foregroundStyle(.foreground)
                    })
                    
                    
                    Menu(content: {
                        Button(action: {
                            
                        }, label: {
                            Label("Add to Queue", systemImage: "text.line.last.and.arrowtriangle.forward")
                        })
                    }, label: {
                        Image(systemName: "ellipsis")
                            .font(.footnote)
                            .foregroundStyle(.foreground)
                    })
                }
                
            }.padding(.vertical)
            
            
            VStack(spacing: -8) {
                Slider(value: $currentTime, in: 0...player.totalTime) { _ in
                    player.updateCurrentTime(currentTime: currentTime)
                }
                .tint(colorScheme == .light ? .black : .white)
                .accessibilityValue("")
                .accessibilityLabel("Player")
                .accessibilityHint("Swipe up or down with one finger to rewind or forward the song of a few seconds")
                .onAppear() {
                    UISlider.appearance().setThumbImage(UIImage(named: "clear"), for: .normal)
                }
                
                HStack {
                    Text(String(format: "%02d:%02d", Int(currentTime/60), Int(currentTime.truncatingRemainder(dividingBy: 60.0))))
                    Spacer()
                    Text(String(format: "%02d:%02d", Int(player.totalTime/60), Int(player.totalTime.truncatingRemainder(dividingBy: 60.0))))
                }
                .font(.footnote)
                .accessibilityHidden(true)
            }.opacity(0.5)
            
            
            HStack {
                Button(action: {
                    player.backwardSong()
                }, label: {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 28))
                })
                .buttonStyle(.plain)
                
                Spacer()
                
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
                        .font(.system(size: 40))
                })
                .buttonStyle(.plain)
                
                Spacer()
                
                Button(action: {
                    player.forwardSong()
                }, label: {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 28))
                })
                .buttonStyle(.plain)
            }.padding(48)
            
            
            HStack {
                Slider(value: $volume, in: 0...1.0, label: {}, minimumValueLabel: {
                    Image(systemName: "speaker.fill")
                }, maximumValueLabel: {
                    Image(systemName: "speaker.wave.3.fill")
                }) { _ in
                    player.setVolume(volume: volume)
                }
                .tint(colorScheme == .light ? .black : .white)
                .accessibilityElement(children: .ignore)
                .accessibilityValue("")
                .accessibilityLabel("Volume")
                .accessibilityHint("Swipe up or down with one finger to adjust the volume")
            }
            .font(.footnote)
            .opacity(0.5)
            
            Spacer()
            
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "quote.bubble")
                })
                .accessibilityLabel("Lyrics")
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "airplayaudio")
                })
                .accessibilityLabel("Airplay")
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "list.bullet")
                })
                .accessibilityLabel("Queue")
            }
            .font(.title3)
            .tint(colorScheme == .light ? .black : .white)
            .opacity(0.5)
            .padding(.horizontal)
        }
        .padding([.horizontal, .bottom], 32)
        .background(content: {
            if player.currentSong != nil {
                ZStack {
                    Image("\(player.currentSong!.album.coverUrl)")
                        .resizable()
                        .ignoresSafeArea()
                    Rectangle()
                        .fill(.thickMaterial)
                        .ignoresSafeArea()
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 50, coordinateSpace: .local)
                .onEnded { value in
                    if (value.translation.height > 50) {
                        isExpanded = false
                    }
                }
        )
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            updateSlider()
        })
        
        
        
    }
    
    
    
    func updateSlider() {
        currentTime = player.audioPlayer?.currentTime ?? 0.0
        
        if (currentTime >= player.totalTime - 0.2) {
            player.forwardSong()
            player.audioPlayer?.currentTime = 0.0
        }
    }
    
    
}

//#Preview {
//    ExpandedPlayerView()
//}
