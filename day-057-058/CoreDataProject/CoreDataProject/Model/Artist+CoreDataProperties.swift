//
//  Artist+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var picture: String?
    @NSManaged public var tracks: NSSet?

}

// MARK: Generated accessors for tracks
extension Artist {

    @objc(addTracksObject:)
    @NSManaged public func addToTracks(_ value: Track)

    @objc(removeTracksObject:)
    @NSManaged public func removeFromTracks(_ value: Track)

    @objc(addTracks:)
    @NSManaged public func addToTracks(_ values: NSSet)

    @objc(removeTracks:)
    @NSManaged public func removeFromTracks(_ values: NSSet)

}

extension Artist : Identifiable {

}
