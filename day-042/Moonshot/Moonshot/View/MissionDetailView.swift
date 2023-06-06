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
                        .padding()
                    
                    if mission.displayDate != "N/A" {
                        Text(mission.displayDate)
                            .padding()
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Divider()
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom)
                        
                        Text(mission.description)
                        
                        Divider()
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
                
                MissionDetailCrewView(roles: roles)
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
