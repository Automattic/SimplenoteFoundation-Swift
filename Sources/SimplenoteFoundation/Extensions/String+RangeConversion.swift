import Foundation


// MARK: - String Range Conversion Helpers
//
extension String {

    /// Converts a `Range<String.Index>` into an UTF16 NSRange.
    ///
    /// - Parameters:
    ///     - range: the range to convert.
    ///
    /// - Returns: the requested `NSRange`.
    ///
    func utf16NSRange(from range: Range<String.Index>) -> NSRange {
        guard let lowerBound = range.lowerBound.samePosition(in: utf16),
            let upperBound = range.upperBound.samePosition(in: utf16) else
        {
            fatalError()
        }

        let location = utf16.distance(from: utf16.startIndex, to: lowerBound)
        let length = utf16.distance(from: lowerBound, to: upperBound)

        return NSRange(location: location, length: length)
    }
}
