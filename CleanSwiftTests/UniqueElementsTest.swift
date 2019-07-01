//
//  UniqueElementsTest.swift
//  CleanSwiftTests
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import XCTest

class IntegerElement: Equatable {
    var number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    static func == (lhs: IntegerElement, rhs: IntegerElement) -> Bool {
        return lhs.number == rhs.number
    }
}

class UniqueElementsTest: XCTestCase {
    
    var array: [IntegerElement] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let element1 = IntegerElement(number: 1)
        let element2 = IntegerElement(number: 45)
        let element3 = IntegerElement(number: 6)
        let element4 = IntegerElement(number: 33)
        let element5 = IntegerElement(number: 6)
        let element6 = IntegerElement(number: 1)
        let element7 = IntegerElement(number: 2)
        
        array.append(element1)
        array.append(element2)
        array.append(element3)
        array.append(element4)
        array.append(element5)
        array.append(element6)
        array.append(element7)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUnique() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(array.uniqueElements.count == 5)
    }

}


