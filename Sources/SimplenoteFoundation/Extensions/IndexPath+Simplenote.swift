import Foundation

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif


// MARK: - IndexPath
//
extension IndexPath {

    func transpose(toSection newSection: Int) -> IndexPath {
        #if os(iOS)
            return IndexPath(row: row, section: newSection)
        #elseif os(macOS)
            return IndexPath(item: item, section: newSection)
        #endif
    }

    #if os(macOS)
    init(row: Int, section: Int) {
        self.init(item: row, section: section)
    }
    #endif
}
