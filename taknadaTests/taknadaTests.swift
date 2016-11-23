import XCTest
@testable import taknada

// The Rules:
// MARK: Lifespan : deinit -> designated -> convenient
// MARK: API : Public/Open
// MARK: To Override
// MARK: Ancestry : Protocol 1, 2, 3; BaseClass 1, 2, 3
// MARK: Stuff : Private/Fileprivate
//
// The Order:
// public/private | static/final | class / struct / enum | override | lazy

class taknadaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
