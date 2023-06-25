//
//  ArtistDetailView.swift
//  CoreDataProject
//
//  Created by nfls on 25/06/2023.
//

import SwiftUI

struct ArtistDetailView: View {
    
    var artist: Artist
    @State private var isFavorite = false
    
    var body: some View {
        GeometryReader { geometry in
                
            ZStack(alignment: .top) {
                
                Image(artist.wrappedPicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width * 0.75)
                    .clipped()
                    .overlay {
                        Color.black.opacity(0.45)
                    }
                    
                ScrollView {
                    
                    VStack {
                        
                        Color.clear
                            .frame(width: geometry.size.width, height: geometry.size.width * 0.60)
                            .overlay(alignment: .bottom) {
                                Text(artist.wrappedName)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                            }
                        
                        LazyVStack {
                            
                            HStack() {
                                VStack {
                                    Text("Listened 213 times")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(artist.wrappedNumberOfTracks) tracks")
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                Button {
                                    isFavorite.toggle()
                                } label: {
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(isFavorite ? .red : .primary)
                                }
                                
                            }
                            .padding()
                            
                            ForEach(artist.wrappedTracks.indices) { index in
                                TrackRowView(track: artist.wrappedTracks[index], showArtist: false)
                            }
                            
                        }
                        .background(.background)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .edgesIgnoringSafeArea([.top])
            
        }
        
    }
}

struct ArtistDetailView_Previews: PreviewProvider {
    static var artist = Artist(context: DataModelController().container.viewContext)
    static var previews: some View {
        ArtistDetailView(artist: artist)
            .preferredColorScheme(.dark)
    }
}
