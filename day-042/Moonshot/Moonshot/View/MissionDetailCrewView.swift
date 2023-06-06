//
//  MissionDetailCrewView.swift
//  Moonshot
//
//  Created by nfls on 06/06/2023.
//

import SwiftUI

struct MissionDetailCrewView: View {
    
    let roles: [MissionDetailView.MissionRole]
    
    var body: some View {
        VStack(alignment: .leading) {

            Text("Crew")
                .font(.title.bold())
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
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
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MissionDetailCrewView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDetailCrewView(roles: [])
    }
}
