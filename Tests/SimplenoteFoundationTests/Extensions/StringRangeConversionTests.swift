import XCTest
@testable import SimplenoteFoundation


// MARK: - String RangeConversion Tests
//
class StringRangeConversionTests: XCTestCase {

    /// Verifies that `indexFromLocation` converts an UTF16 Location into a valid String.Index
    ///
    func testIndexFromLocationProperlyConvertsUTF16RangeIntoStringIndex() {
        let samples: [(NSString, String, String)] = [
            ("Hello World!", "World", "Hello "),
            ("Hello 🌍!", "🌍", "Hello "),
            ("Hello 🇮🇳!", "🇮🇳", "Hello "),
            ("Hello 🇮🇳 🌍!", "🌍", "Hello 🇮🇳 ")
        ]

        for (nsString, wordToCapture, expectedPrefix) in samples {
            let string: String = nsString as String
            let nsRange = nsString.range(of: wordToCapture)
            let index = string.indexFromLocation(nsRange.location)!

            let wordCaptured = String(string.prefix(upTo: index))

            XCTAssertEqual(expectedPrefix, wordCaptured)
        }
    }

    /// Verifies that `relativeLocation(for: in:)` does not alter the Location, whenever the specified Range covers the full string
    ///
    func testTransportIndexReturnsTheUnmodifiedIndexWhenTheRangeEnclosesTheFullReceiverRange() {
        let text = "this 🌎 is supposed to be a single but relatively long line of text"
        let fullRange = text.startIndex ..< text.endIndex

        for location in Int.zero ..<  text.count {
            let index = text.index(text.startIndex, offsetBy: location)
            XCTAssertEqual(text.transportIndex(index, to: fullRange, in: text), index)
        }
    }

    /// Verifies that `transportIndex(_:to:in:)` converts the specified Absolute Location into a Relative Location, with regards of a specified range
    ///
    func testTransportIndexReturnsTheExpectedLocationWhenTheRangeIsNotTheFullString() {
        let lhs = "this 🌎 "
        let substring = "is supposed to be"
        let rhs = " a single but relatively long line of text"

        let text = lhs + substring + rhs
        let substringRange = text.range(of: substring)!

        for location in Int.zero ..< substring.count {
            let unmappedIndex = text.index(text.startIndex, offsetBy: location + lhs.count)
            let expectedIndex = substring.index(substring.startIndex, offsetBy: location)

            XCTAssertEqual(text.transportIndex(unmappedIndex, to: substringRange, in: substring), expectedIndex)
        }
    }

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
