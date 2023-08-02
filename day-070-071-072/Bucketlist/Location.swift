//
//  Location.swift
//  Bucketlist
//
//  Created by nfls on 28/07/2023.
//

import MapKit
import Foundation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitute: Double
    let longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitute, longitude: longitude)
    }
    
    static var example: Location {
        Location(id: UUID(), name: "Center", description: "Of the coordinate system", latitute: 0.0, longitude: 0.0)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
