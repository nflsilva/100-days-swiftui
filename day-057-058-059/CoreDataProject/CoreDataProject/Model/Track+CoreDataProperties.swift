//
//  Track+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var duration: Int32
    @NSManaged public var artist: Artist?

}

extension Track : Identifiable {

}
