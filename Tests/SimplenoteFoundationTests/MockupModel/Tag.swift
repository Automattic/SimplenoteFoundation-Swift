import Foundation
import CoreData


// MARK: - Tag Mockup Entity
//
@objcMembers
class Tag: NSManagedObject {

    @NSManaged
    var simperiumKey: String!

    @NSManaged
    var name: String?
}
