//
//  Track+CoreDataClass.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//
//

import Foundation
import CoreData

@objc(Track)
public class Track: NSManagedObject {
    
    public var wrappedName: String {
        return name ?? "Unknown"
    }
    
    public var albumCover: String {
        let n = Int.random(in: 0...6)
        return "album-\(n)"
    }
    
    public var wrappedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(duration)) ?? "\(duration / 60):\(duration % 60)"
    }
}
