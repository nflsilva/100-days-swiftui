//
//  Location.swift
//  Bucketlist
//
//  Created by nfls on 28/07/2023.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitute: Double
    let longitude: Double
}
