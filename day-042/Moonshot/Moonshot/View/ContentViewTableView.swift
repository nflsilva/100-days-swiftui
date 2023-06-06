//
//  ContentViewTableView.swift
//  Moonshot
//
//  Created by nfls on 06/06/2023.
//

import SwiftUI

struct ContentViewTableView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    private let rows = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionDetailView(mission: mission, astronauts: astronauts)
                    } label: {

                        HStack  {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                HStack {
                                    ForEach(mission.crewMembers, id:\.self) {
                                        Text($0.capitalized)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                }
                                
                                Text(mission.displayDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.lightBackground)
                        )
                        
                    }
                }
                
            }
            .padding()
        }
    }
}

struct ContentViewTableView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        ContentViewTableView(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
