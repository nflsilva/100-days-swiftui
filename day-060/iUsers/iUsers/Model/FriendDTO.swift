//
//  FriendDTO.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import Foundation

struct FriendDTO: Identifiable, Decodable {
    
    let id: UUID
    let name: String
    
    var username: String {
        return "@" + name
            .replacingOccurrences(of: " ", with: "")
            .lowercased()
    }
    
}
