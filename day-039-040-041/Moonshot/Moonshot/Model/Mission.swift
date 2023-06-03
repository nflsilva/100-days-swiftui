//
//  Mission.swift
//  Moonshot
//
//  Created by nfls on 03/06/2023.
//

import Foundation


struct Mission: Decodable, Identifiable {
    
    struct Role: Decodable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [Role]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var displayDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
