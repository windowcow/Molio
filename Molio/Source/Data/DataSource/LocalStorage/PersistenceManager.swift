import Foundation
import CoreData

class PersistenceManager {
    static let shared = PersistenceManager()
    let moliomModelName: String = "MolioModel"
    let persistenceContainer: NSPersistentContainer
    
    private init() {
        persistenceContainer = NSPersistentContainer(name: moliomModelName)
        persistenceContainer.loadPersistentStores { _, error in
            guard let error = error else { return }
            fatalError("Core Data Stack failed : \(error)")
        }
    }
    
    var context: NSManagedObjectContext {
        return persistenceContainer.viewContext
    }
    
    func saveContext(){
        let context = persistenceContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved Error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
