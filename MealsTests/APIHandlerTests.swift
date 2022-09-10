//
//  APIHandlerTests.swift
//  MealsTests
//
//  Created by Revive on 9/9/22.
//

import XCTest
@testable import Meals

class APIHandlerTests: XCTestCase {
    var handler: APIHandler?
    
    override func setUpWithError() throws {
        handler = APIHandler.shared
    }

    override func tearDownWithError() throws {
        handler = nil
    }

    func test_APIHandler_isNotNil() {
        XCTAssertNotNil(handler)
    }
    
    func test_APIHandler_doesNotWork_WithOnlyBaseMealUrl() {
        let baseMealsUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c="

        handler?.getData(from: baseMealsUrl, completion: { data, statusMessage in
            XCTAssertNil(data)
            XCTAssertEqual(statusMessage, "APIHandler: No data")
        })
    }
    
    func test_APIHandler_doesNotWorkWithBaseRecipeUrl() {
        let baseRecipeURl = RecipeDetailViewModel().baseRecipeUrl
        
        handler?.getData(from: baseRecipeURl, completion: { data, statusMessage in
            XCTAssertNil(data)
            XCTAssertEqual(statusMessage, "APIHandler: No data")
        })
    }
    
    func test_APIHandler_doesNotWorkWithBadUrl() {
        let badUrl = "htp://xyz"
        
        handler?.getData(from: badUrl, completion: { data, statusMessage in
            XCTAssertNil(data)
            XCTAssertEqual(statusMessage, "APIHandler: Invalid URL")
        })
    }
    
    func test_APIHandler_worksWithGoodUrl() {
        let goodUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52961"
        
        handler?.getData(from: goodUrl, completion: { data, statusMessage in
            XCTAssertNotNil(data)
            XCTAssertEqual(statusMessage, "Data retrieved successfully")
        })
    }

}
