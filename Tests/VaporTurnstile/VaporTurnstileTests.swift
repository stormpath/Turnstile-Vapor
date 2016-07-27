import XCTest
@testable import VaporTurnstile

class VaporTurnstileTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(VaporTurnstile().text, "Hello, World!")
    }


    static var allTests : [(String, (VaporTurnstileTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
