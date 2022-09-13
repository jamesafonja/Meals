//
//  RecipeDetailViewModelTests.swift
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

class RecipeDetailViewModelTests: XCTestCase {
    var vm: RecipeDetailViewModel?
    var selectedMealId: String?
    var expectation: XCTestExpectation?

    override func setUpWithError() throws {
        vm = RecipeDetailViewModel()
        vm?.selectedMealId = "52961"
    }

    override func tearDownWithError() throws {
        vm = nil
        selectedMealId = nil
    }

    func test_recipeDetailViewModel_isNotNil() {
        XCTAssertNotNil(vm)
    }
    
    func test_recipeDetailViewModel_baseRecipeUrl_isNotEmpty() {
        guard let vm = vm else { return }
        XCTAssertFalse(vm.baseRecipeUrl.isEmpty)
    }
    
    func test_recipeDetailViewModel_baseRecipeUrl_plus_selectedMealId_isValidURL() {
        guard
            let vm = vm,
            let id = selectedMealId
        else { return }
        
        XCTAssertNotNil(URL(string: vm.baseRecipeUrl + id))
    }
    
    func test_recipeDetailViewModel_getRecipe_works() {
        
        expectation = XCTestExpectation(description: #function)

        guard let vm = vm else { return }

        vm.getRecipe { [weak self] success in
            if success {
                XCTAssertTrue(success)
                self?.expectation?.fulfill()
            } else {
                XCTFail("Expected meals but failed.")
            }
        }

        wait(for: [expectation ?? XCTestExpectation()], timeout: 5.0)
    }
    
    
    func test_recipeDetailViewModel_recipe_isNil_OnInit() {
        guard let vm = vm else { return }
        XCTAssertNil(vm.recipe)
    }
    
    func test_recipeDetailViewModel_recipe_isNotEmpty_ifSuccess() {
        
        expectation = XCTestExpectation(description: #function)
        
        guard let vm = vm else { return }
        
        vm.getRecipe { [weak self] success in
            if success {
                XCTAssertTrue(success)
                self?.expectation?.fulfill()
            } else {
                XCTFail("Expected recipe but failed")
            }
        }
        
        wait(for: [expectation ?? XCTestExpectation()], timeout: 3)
    }

}
