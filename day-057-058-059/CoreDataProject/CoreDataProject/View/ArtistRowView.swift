//
//  ArtistRowView.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//

import SwiftUI

struct ArtistRowView: View {
    
    var artist: Artist
    
    var body: some View {
        
        NavigationLink(destination: ArtistDetailView(artist: artist)) {
            HStack {
                Image(artist.wrappedPicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.primary)
                    }
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(artist.wrappedName)
                        .font(.headline)
                    Text("\(artist.wrappedNumberOfTracks) tracks")
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
        }
        .foregroundColor(.primary)
        
    }
}

struct ArtistRowView_Previews: PreviewProvider {
    static var artist = Artist(context: DataModelController().container.viewContext)
    static var previews: some View {
        ArtistRowView(artist: artist)
    }
}
