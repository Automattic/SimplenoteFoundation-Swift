import Foundation
import CoreData


// MARK: - NSAttributeDescription Helpers
//
extension NSAttributeDescription {

    /// Convenience Initializers
    ///
    convenience init(property: Selector, type: NSAttributeType) {
        self.init()
        name = NSStringFromSelector(property)
        attributeType = type
    }
}
