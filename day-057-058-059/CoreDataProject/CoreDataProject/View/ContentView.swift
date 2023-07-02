//
//  ContentView.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationView {
            TabView {
                AwesomeTemplateView(filterKey: "name", filterValue: searchTerm) { (a: Artist) in
                    ArtistRowView(artist: a)
                }
                .tabItem {
                    Image(systemName: "person")
                }
                    
                AwesomeTemplateView(filterKey: "name", filterValue: searchTerm) { (a: Track) in
                    TrackRowView(track: a, showArtist: true)
                }
                .tabItem {
                    Image(systemName: "music.note")
                }
                
                AddDataView()
                    .tabItem {
                        Image(systemName: "person.badge.plus")
                    }
            }
            .navigationTitle("Newnamp")
        }
        .searchable(text: $searchTerm)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
