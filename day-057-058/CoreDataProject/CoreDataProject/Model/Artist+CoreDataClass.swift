//
//  Artist+CoreDataClass.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//
//

import Foundation
import CoreData

@objc(Artist)
public class Artist: NSManagedObject {

    public var wrappedName: String {
        return name ?? "Unknown"
    }
    
    public var wrappedPicture: String {
        return picture ?? "bb"
    }
    
    public var wrappedNumberOfTracks: Int {
        return tracks?.count ?? 0
    }
}
