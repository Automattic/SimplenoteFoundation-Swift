import Foundation


// MARK: - NSObject + Simplenote
//
extension NSObject {

    /// Returns the receiver's classname as a string, not including the namespace.
    ///
    class var classNameWithoutNamespaces: String {
        String(describing: self)
    }
}
