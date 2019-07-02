//
//  UserListWorkerTests.swift
//  CleanSwift
//
//  Created by Josep Escobar on 02/07/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

@testable import CleanSwift
import XCTest

class UserListWorkerTests: XCTestCase {

    // MARK: Subject under test
    var worker: UserListWorker!
    private var arrayUsers: [User] = []

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupUserListWorker()
        let data: Data = usersJsonMock.data(using: String.Encoding.utf8)!
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode([User].self, from: data)
            arrayUsers = decodedResponse
        } catch {
            fatalError("Cannot decode JSON Mock Response")
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupUserListWorker() {
        worker = UserListWorker()
    }

    // MARK: Tests

    func testSearchUser() {
        let expectation = self.expectation(description: "SEARCH_USER")

        worker.filterArrayBySearchText(searchText: "klaus", usersArray: arrayUsers) { users in
            XCTAssertNotNil(users)
            XCTAssertTrue(users.count == 1)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testBlackListExclusion() {
        let user = arrayUsers[0]
        worker.addUserToBlackList(user: user)
        let users = worker.filterBlackList(users: arrayUsers)

        XCTAssertTrue(arrayUsers.count > users.count)
        XCTAssertTrue(arrayUsers.count == users.count + 1)

        // Reset blacklist
        var blacklistArray = UserDefaults.standard.array(forKey: worker.blackListKey)

        if let blackListArrayValue = blacklistArray as? [String], let uuid = user.login?.uuid {
            if blackListArrayValue.last == uuid {
                blacklistArray?.remove(at: blackListArrayValue.count - 1)
            }
        }

        UserDefaults.standard.set(blacklistArray, forKey: worker.blackListKey)
    }
}
