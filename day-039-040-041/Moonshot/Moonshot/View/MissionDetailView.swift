//
//  MissionDetailView.swift
//  Moonshot
//
//  Created by nfls on 05/06/2023.
//

import SwiftUI

struct MissionDetailView: View {
    
    struct MissionRole {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let roles: [MissionRole]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        var roles = [MissionRole]()
        for member in mission.crew {
            guard let astronaut = astronauts[member.name] else {
                fatalError("Astronaut \(member.name) not found.")
            }
            
            roles.append(MissionRole(role: member.role, astronaut: astronaut))
        }
        self.roles = roles
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)

                    VStack(alignment: .leading) {
                        
                        Divider()
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom)
                        
                        Text(mission.description)
                        
                        Divider()
                            .padding(.vertical)
                        
                        Text("Crew")
                            .font(.title.bold())
                    }
                    .padding(.horizontal)
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(roles, id: \.astronaut.name) { role in
                            NavigationLink {
                                AstronautDetailView(astronaut: role.astronaut)
                            } label: {
                                HStack {
                                    
                                    Image(role.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay {
                                            Capsule().strokeBorder(.white, lineWidth: 1)
                                        }
                                    
                                    VStack(alignment: .leading) {
                                        Text(role.astronaut.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(role.role)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionDetailView_Previews: PreviewProvider {

    static var previews: some View {
        let missions: [Mission] = Bundle.main.decode("missions.json")
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        
        MissionDetailView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
