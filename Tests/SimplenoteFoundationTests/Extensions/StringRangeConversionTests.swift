import XCTest
@testable import SimplenoteFoundation


// MARK: - String RangeConversion Tests
//
class StringRangeConversionTests: XCTestCase {

    /// Verifies that `indexFromLocation` converts an UTF16 Location into a valid String.Index
    ///
    func testIndexFromLocationProperlyConvertsUTF16RangeIntoStringIndex() {
        let samples: [(String, String, String)] = [
            ("Hello World!", "World", "Hello "),
            ("Hello 🌍!", "🌍", "Hello "),
            ("Hello 🇮🇳!", "🇮🇳", "Hello "),
            ("Hello 🇮🇳 🌍!", "🌍", "Hello 🇮🇳 ")
        ]

        for (text, wordToCapture, expectedPrefix) in samples {
            let nsRange = text.nsString.range(of: wordToCapture)
            let index = text.indexFromLocation(nsRange.location)!

            let wordCaptured = String(text.prefix(upTo: index))

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
        let substring0 = "this 🌎 "
        let substring1 = "is supposed to be"
        let substring2 = " a single but relatively long line of text"

        let text = substring0 + substring1 + substring2
        let rangeOfSubstring1 = text.range(of: substring1)!

        for location in Int.zero ..< substring1.count {
            let unmappedIndex = text.index(text.startIndex, offsetBy: substring0.count + location)
            let expectedIndex = substring1.index(substring1.startIndex, offsetBy: location)

            XCTAssertEqual(text.transportIndex(unmappedIndex, to: rangeOfSubstring1, in: substring1), expectedIndex)
        }
    }

    /// Verifies that `utf16NSRange` properly converts a `Range<String.Index>` into a NSString NSRange
    ///
    func testUTF16NSRangeProperlyConvertsSwiftRangesIntoNSStringRanges() {
        let string = "Hello 🇮🇳 World 🌎!"
        let wordToCapture = "🌎"

        let swiftWordRange = string.range(of: wordToCapture)!
        let swiftWordText = String(string[swiftWordRange])

        let nsWordRange = string.utf16NSRange(from: swiftWordRange)
        let nsWordText = string.nsString.substring(with: nsWordRange)

        XCTAssertEqual(swiftWordText, wordToCapture)
        XCTAssertEqual(nsWordText, wordToCapture)
    }
}
