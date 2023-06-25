//
//  TrackRowView.swift
//  CoreDataProject
//
//  Created by nfls on 25/06/2023.
//

import SwiftUI

struct TrackRowView: View {
    
    var track: Track
    var showArtist: Bool
    
    var body: some View {

        HStack {
            Image(track.albumCover)
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
                Text(track.wrappedName)
                    .font(.headline)
                
                if showArtist {
                    Text(track.artist?.wrappedName ?? "Unknown artist")
                        .font(.subheadline)
                }
                
                Text(track.wrappedDuration)
                    .font(.caption)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
    
}

struct TrackRowView_Previews: PreviewProvider {
    static var track = Track(context: DataModelController().container.viewContext)
    
    static var previews: some View {
        TrackRowView(track: track, showArtist: true)
    }
}
