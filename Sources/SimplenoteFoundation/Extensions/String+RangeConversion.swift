import Foundation


// MARK: - String Range Conversion Helpers
//
extension String {

    /// Converts a Location (expressed as Integer) into a String.Index
    ///
    public func indexFromLocation(_ location: Int) -> String.Index? {
        guard let unicodeLocation = utf16.index(utf16.startIndex, offsetBy: location, limitedBy: utf16.endIndex),
            let location = unicodeLocation.samePosition(in: self) else {
                return nil
        }

        return location
    }

    /// Maps a `String.Index` in the receiver's coordinates into coordinates valid for the specified Substring, in the target Range
    ///
    public func transportIndex(_ index: String.Index, to substring: String, in range: Range<String.Index>) -> String.Index? {
        let locationInSubstring = distance(from: startIndex, to: index) - distance(from: startIndex, to: range.lowerBound)
        return substring.index(substring.startIndex, offsetBy: locationInSubstring)
    }

    /// Converts a `Range<String.Index>` into an UTF16 NSRange.
    ///
    public func utf16NSRange(from range: Range<String.Index>) -> NSRange {
        guard let lowerBound = range.lowerBound.samePosition(in: utf16), let upperBound = range.upperBound.samePosition(in: utf16) else {
            fatalError()
        }

        let location = utf16.distance(from: utf16.startIndex, to: lowerBound)
        let length = utf16.distance(from: lowerBound, to: upperBound)

        return NSRange(location: location, length: length)
    }
}
