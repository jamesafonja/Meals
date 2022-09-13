//
//  MealListViewModelTests.swift
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

class MealListViewModelTests: XCTestCase {
    var vm: MealListViewModel?
    var expectation: XCTestExpectation?
    
    override func setUpWithError() throws {
        vm = MealListViewModel()

    }

    override func tearDownWithError() throws {
        vm = nil
        expectation = nil
    }

    func test_mealListViewModel_isNotNil() {
        XCTAssertNotNil(vm)
    }
    
    func test_mealListViewModel_baseMealsURL_isNotEmpty() {
        guard let vm = vm else { return }
        XCTAssertTrue(!vm.baseMealsUrl.isEmpty)
    }
    
    func test_mealListViewModel_baseMealsUrl_plus_category_isValidURL() {
        guard let vm = vm else { return }
        
        let mealType: MealType = .dessert
        let urlString = vm.baseMealsUrl + mealType.rawValue
        
        XCTAssertNotNil(URL(string: urlString))
    }
    
    func test_mealListViewModel_getMeals_works() {
        
        expectation = XCTestExpectation(description: #function)
        guard let vm = vm else { return }
                
        vm.getMeals(ofType: .dessert) { [weak self] success in
            if success {
                XCTAssertTrue(success)
                self?.expectation?.fulfill()
            } else {
                XCTFail("Expected meals but failed.")
            }
        }
        
        wait(for: [expectation ?? XCTestExpectation()], timeout: 3)
    }
    
    func test_mealListViewModel_statusMessage_isNotEmptyAfterRunning() {
        
        expectation = XCTestExpectation(description: #function)
        guard let vm = vm else { return }
        
        vm.getMeals(ofType: .dessert) { [weak self] _ in
            XCTAssertTrue(!vm.statusMessage.isEmpty)
            XCTAssertTrue(vm.statusMessage.trimmingCharacters(in: .whitespaces).count > 0)
            self?.expectation?.fulfill()
        }
        
        wait(for: [expectation ?? XCTestExpectation()], timeout: 3)
    }
    
    func test_mealListViewModel_meals_isEmpty_OnInit() {
        guard let vm = vm else { return }
        XCTAssertTrue(vm.meals.isEmpty)
    }
    
    func test_mealListViewModelMeals_isNotEmpty_ifSuccess() {
        
        expectation = XCTestExpectation(description: #function)
        guard let vm = vm else { return }
        
        vm.getMeals(ofType: .dessert) { [weak self] success in
            if success {
                XCTAssertTrue(vm.meals.count > 0)
                self?.expectation?.fulfill()
            }
        }
        
        wait(for: [expectation ?? XCTestExpectation()], timeout: 10)
    }
}
