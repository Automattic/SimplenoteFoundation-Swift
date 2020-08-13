import Foundation
import CoreData
@testable import SimplenoteFoundation


/// MockupStorageManager: InMemory CoreData Stack.
///
class MockupStorageManager {

    /// Returns the Storage associated with the View Thread.
    ///
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    /// Persistent Container: Holds the full CoreData Stack
    ///
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimplenoteMockup", managedObjectModel: managedModel)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("[MockupStorageManager] Fatal Error: \(error) [\(error.userInfo)]")
            }
        }

        return container
    }()

    /// Nukes the specified Object
    ///
    func delete(_ object: NSManagedObject) {
        viewContext.delete(object)
    }

    /// This method effectively destroys all of the stored data, and generates a blank Persistent Store from scratch.
    ///
    func reset() {
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        let storeDescriptor = self.storeDescription
        let viewContext = persistentContainer.viewContext

        viewContext.performAndWait {
            do {
                viewContext.reset()
                for store in storeCoordinator.persistentStores {
                    try storeCoordinator.remove(store)
                }
            } catch {
                fatalError("☠️ [MockupStorageManager] Cannot Destroy persistentStore! \(error)")
            }

            storeCoordinator.addPersistentStore(with: storeDescriptor) { (_, error) in
                guard let error = error else {
                    return
                }

                fatalError("☠️ [MockupStorageManager] Unable to regenerate Persistent Store! \(error)")
            }

            NSLog("💣 [MockupStorageManager] Stack Destroyed!")
        }
    }

    /// "Persists" the changes
    ///
    func save() {
        try? viewContext.save()
    }
}


// MARK: - Descriptors
//
extension MockupStorageManager {

    /// Returns the Application's ManagedObjectModel
    ///
    var managedModel: NSManagedObjectModel {
        let noteDescriptor = NSEntityDescription()
        noteDescriptor.name = Note.entityName
        noteDescriptor.managedObjectClassName = NSStringFromClass(Note.classForCoder())
        noteDescriptor.properties = [
            NSAttributeDescription(property: #selector(getter: Note.simperiumKey), type: .stringAttributeType),
            NSAttributeDescription(property: #selector(getter: Note.content), type: .stringAttributeType),
            NSAttributeDescription(property: #selector(getter: Note.creationDate), type: .dateAttributeType),
            NSAttributeDescription(property: #selector(getter: Note.modificationDate), type: .dateAttributeType),
        ]

        let tagDescriptor = NSEntityDescription()
        tagDescriptor.name = Tag.entityName
        tagDescriptor.managedObjectClassName = NSStringFromClass(Tag.classForCoder())
        tagDescriptor.properties = [
            NSAttributeDescription(property: #selector(getter: Tag.simperiumKey), type: .stringAttributeType),
            NSAttributeDescription(property: #selector(getter: Tag.name), type: .stringAttributeType)
        ]

        let model = NSManagedObjectModel()
        model.entities = [noteDescriptor]

        return model
    }

    /// Returns the PersistentStore Descriptor
    ///
    var storeDescription: NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        return description
    }
}
