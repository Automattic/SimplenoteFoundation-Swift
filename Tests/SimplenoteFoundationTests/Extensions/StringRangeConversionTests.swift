import XCTest
@testable import SimplenoteFoundation


// MARK: - String RangeConversion Tests
//
class StringRangeConversionTests: XCTestCase {

    /// Verifies that `utf16NSRange` properly converts a `Range<String.Index>` into a NSString NSRange
    ///
    func testUTF16NSRangeProperlyConvertsSwiftRangesIntoNSStringRanges() {
        let string = "Hello 🇮🇳 World 🌎!"
        let wordToCapture = "🌎"

        let swiftRange = string.range(of: wordToCapture)!
        let swiftWord = String(string[swiftRange])

        let foundationString = string as NSString
        let foundationRange = string.utf16NSRange(from: swiftRange)
        let foundationWord = foundationString.substring(with: foundationRange)

        XCTAssertEqual(swiftWord, wordToCapture)
        XCTAssertEqual(foundationWord, wordToCapture)
    }
}
