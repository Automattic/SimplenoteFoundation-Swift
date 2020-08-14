import Foundation
import CoreData


// MARK: - Note Mockup Entity
//
@objcMembers
class MockupNote: NSManagedObject {

    @NSManaged
    var simperiumKey: String!

    @NSManaged
    var modificationDate: Date!

    @NSManaged
    var creationDate: Date!

    @NSManaged
    var content: String!
}
