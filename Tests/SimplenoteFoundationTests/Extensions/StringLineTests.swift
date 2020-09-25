import XCTest
@testable import SimplenoteFoundation


// MARK: - String RangeConversion Tests
//
class StringLineTests: XCTestCase {

    /// Verifies that `line(at:)` returns a touple with Range + Text for the Line at the specified Location
    ///
    func testLineAtIndexReturnsTheExpectedLineForTheSpecifiedLocation() {
        let lines = [
            "alala lala long 🌎 long le long long long!\n",
            "this is supposed to 🇮🇳 be the second line\n",
            "and this would be the 🌎 third line in the document\n",
            "only to be followed by a 🇮🇳 trailing and final line!"
        ]

        let text = lines.joined()
        var padding = Int.zero

        for expectedLine in lines {
            for location in Int.zero ..< expectedLine.count {
                let index = text.index(text.startIndex, offsetBy: location + padding)
                let (lineRange, lineText) = text.line(at: index)

                XCTAssertEqual(lineText, expectedLine)
                XCTAssertEqual(String(text[lineRange]), lineText)
            }

            padding += expectedLine.count
        }
    }

    /// Verifies that `split(at:)` properly cuts the receiver at the specified location
    ///
    func testSplitAtLocationReturnsTheExpectedSubstrings() {
        let lhs = "some random 🇮🇳 text on the left hand side"
        let rhs = "and some more 🌎 random text on the right hand side"
        let text = lhs + rhs
        let lhsEndIndex = text.index(text.startIndex, offsetBy: lhs.count)

        let (splitLHS, splitRHS) = text.split(at: lhsEndIndex)
        XCTAssertEqual(lhs, splitLHS)
        XCTAssertEqual(rhs, splitRHS)
    }

    /// Verifies that `split(at:)` properly handles Empty Strings
    ///
    func testSplitAtLocationReturnsEmptyStringsWhenTheReceiverIsEmpty() {
        let text = ""
        let (lhs, rhs) = text.split(at: text.startIndex)

        XCTAssertTrue(lhs.isEmpty)
        XCTAssertTrue(rhs.isEmpty)
    }

    /// Verifies that `split(at:)` returns an empty `RHS` string, whenever the cut location matches the end of the receiver
    ///
    func testSplitAtLocationProperlyHandlesLocationsAtTheEndOfTheString() {
        let text = "this is supposed to be a single 🌎 but relatively long line of text"
        let (lhs, rhs) = text.split(at: text.endIndex)

        XCTAssertEqual(lhs, text)
        XCTAssertEqual(rhs, "")
    }
}
