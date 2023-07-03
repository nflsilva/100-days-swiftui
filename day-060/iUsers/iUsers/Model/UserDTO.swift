//
//  UserDTO.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import Foundation

struct UserDTO: Identifiable, Decodable {
    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    //let registered: Date
    let tags: [String]
    let friends: [FriendDTO]
    
    var username: String {
        return "@" + name
            .replacingOccurrences(of: " ", with: "")
            .lowercased()
    }
    
    var randomTags: String {
        var r = ""
        let n = 3
        for f in 0..<n {
            r += tags.randomElement() ?? "@unknown"
            if f < (n - 1) {
                r += ", "
            }
        }
        return r
    }
    
}
