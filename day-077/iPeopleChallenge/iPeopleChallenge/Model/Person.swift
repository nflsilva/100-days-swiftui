//
//  Person.swift
//  iPeopleChallenge
//
//  Created by nfls on 10/08/2023.
//

import Foundation

struct Person: Identifiable, Codable, Hashable {
    
    let id: UUID = UUID()
    let name: String
    let picturePath: String

}
