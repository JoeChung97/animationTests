//
//  TesterAppTests.swift
//  TesterAppTests
//
//  Created by Joseph Chung on 4/2/21.
//

import XCTest
@testable import TesterApp

class TesterAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let s1 = Utils.generateRandomString(length: 12)
        let s2 = Utils.generateRandomString(length: 12)
        XCTAssert(s1.count == 12)
        XCTAssert(s2.count == 12)
        XCTAssert(s1 != s2)
    }
    
    func randomUserTest() throws {
        let u1 = User.generateRandomUser()
        print(u1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
