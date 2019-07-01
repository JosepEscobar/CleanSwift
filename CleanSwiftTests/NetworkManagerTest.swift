//
//  NetworkManagerTest.swift
//  CleanSwiftTests
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import XCTest

class NetworkManagerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let expectation = self.expectation(description: "API_CALL_TEST")

        let networkManager = NetworkManager()
        networkManager.getUsers { users in
            XCTAssertNotNil(users)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
