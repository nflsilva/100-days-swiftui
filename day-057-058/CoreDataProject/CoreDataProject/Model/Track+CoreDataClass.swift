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
}
