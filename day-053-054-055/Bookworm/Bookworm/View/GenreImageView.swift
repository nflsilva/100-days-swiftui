//
//  GenreImageView.swift
//  Bookworm
//
//  Created by nfls on 20/06/2023.
//

import SwiftUI

struct GenreImageView: View {
    
    let genre: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(genre)
                .resizable()
                .scaledToFit()
        
            Text(genre.uppercased())
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.black.opacity(0.75))
                .clipShape(Capsule())
                .padding()
        }
    }
}

struct GenreImageView_Previews: PreviewProvider {
    static var previews: some View {
        GenreImageView(genre: AddBookView.genres[0])
    }
}
