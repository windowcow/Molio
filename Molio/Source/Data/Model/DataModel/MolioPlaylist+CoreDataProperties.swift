import Foundation
import CoreData


extension MolioPlaylist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MolioPlaylist> {
        return NSFetchRequest<MolioPlaylist>(entityName: "MolioPlaylist")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var filters: [String]?
    @NSManaged public var id: UUID?
    @NSManaged public var musics: [String]?
    @NSManaged public var name: String?

}

extension MolioPlaylist : Identifiable {

}
