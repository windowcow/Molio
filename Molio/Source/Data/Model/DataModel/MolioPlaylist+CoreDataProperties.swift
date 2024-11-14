import Foundation
import CoreData


extension MolioPlaylist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MolioPlaylist> {
        return NSFetchRequest<MolioPlaylist>(entityName: "MolioPlaylist")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var filters: NSObject?
    @NSManaged public var createdAt: Date?
    @NSManaged public var musics: NSObject?

}

extension MolioPlaylist : Identifiable {

}
