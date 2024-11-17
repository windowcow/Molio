//
//  Playlist+CoreDataProperties.swift
//  Molio
//
//  Created by p_kxn_g on 11/17/24.
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var filters: [String]
    @NSManaged public var id: UUID
    @NSManaged public var musicISRCs: [String]
    @NSManaged public var name: String

}

extension Playlist : Identifiable {

}
