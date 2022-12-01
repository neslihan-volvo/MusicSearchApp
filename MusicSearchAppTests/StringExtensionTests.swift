import XCTest
@testable import MusicSearchApp

final class StringExtensionTests: XCTestCase {
    
    func testStringExtension_whenSearchStringCreated_returnStringWithoutSpacesAndNewLines() throws {
        let keyword = """
        any keyword with space
        and new line
        """
        let searchString  = keyword.makeSearchString()
        XCTAssertFalse(searchString.contains(" "))
        XCTAssertFalse(searchString.contains("\n"))
    }
}
