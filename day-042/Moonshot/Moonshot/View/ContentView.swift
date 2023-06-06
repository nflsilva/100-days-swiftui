//
//  ContentView.swift
//  Moonshot
//
//  Created by nfls on 03/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    private let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    private let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var isGridMode = true
    
    var body: some View {
        NavigationView {
            ZStack {
                if isGridMode {
                    ContentViewGridMode(astronauts: astronauts, missions: missions)
                }
                else {
                    ContentViewTableView(astronauts: astronauts, missions: missions)
                } 
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                HStack {
                    Button {
                        isGridMode.toggle()
                    } label : {
                        Image(systemName: isGridMode ? "list.bullet" : "square.grid.2x2")
                            .tint(.white)
                    }
                }
            }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
