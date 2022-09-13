//
//  APIHandlerTests.swift
//  MealsTests
//
//  Created by Revive on 9/9/22.
//

import XCTest
@testable import Meals

/*
 Asynchronous tests use expectations per Apple docs:-
 https://developer.apple.com/documentation/xctest/asynchronous_tests_and_expectations
 */

class APIHandlerTests: XCTestCase {
    var handler: APIHandler?
    var expectation: XCTestExpectation?
    
    override func setUpWithError() throws {
        handler = APIHandler.shared
    }

    override func tearDownWithError() throws {
        handler = nil
        expectation = nil
    }

    func test_APIHandler_isNotNil() {
        XCTAssertNotNil(handler)
    }
    
    func test_APIHandler_fails_whenGivenBadUrlString() {
        expectation = XCTestExpectation(description: #function)

        let badUrlString = "htp://badUrlString"

        handler?.getData(from: badUrlString, completion: { [weak self] data, statusMessage in
            XCTAssertNil(data)
            self?.expectation?.fulfill()
        })
        
        wait(for: [expectation ?? XCTestExpectation()], timeout: 3.0)
        
    }
    
    func test_APIHandler_worksWithGoodUrl() {
        expectation = XCTestExpectation(description: #function)
        
        let goodUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52961"
        var msg = ""
        var fetchedData: Data?
        
        handler?.getData(from: goodUrl, completion: { [weak self] data, statusMessage in
            msg = statusMessage
            fetchedData = data
            self?.expectation?.fulfill()
        })
        
        wait(for: [expectation ?? XCTestExpectation()], timeout: 3.0)
        
        XCTAssertNotNil(fetchedData)
        XCTAssertEqual(msg, "Data retrieved successfully")
    }

}
