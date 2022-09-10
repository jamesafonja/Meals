//
//  RecipeDetailViewModelTests.swift
//  MealsTests
//
//  Created by Revive on 9/9/22.
//

import XCTest
@testable import Meals

class RecipeDetailViewModelTests: XCTestCase {
    var vm: RecipeDetailViewModel?
    var selectedMealId: String?

    override func setUpWithError() throws {
        vm = RecipeDetailViewModel()
        selectedMealId = "52961"
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
        guard let vm = vm else { return }
                
        vm.selectedMealId = selectedMealId
        
        vm.getRecipe { success in
            XCTAssertTrue(success)
        }
    }
    
    func test_recipeDetailViewModel_statusMessage_isNotEmptyAfterRunning() {
        guard let vm = vm else { return }
        
        vm.selectedMealId = selectedMealId
        
        vm.getRecipe { [weak self] success in
            guard let message = self?.vm?.statusMessage else { return }
            
            XCTAssertNotNil(message)
            XCTAssertFalse(message.isEmpty)
        }
    }
    
    func test_recipeDetailViewModel_recipe_isNil_OnInit() {
        guard let vm = vm else { return }
        
        XCTAssertNil(vm.recipe)
    }
    
    func test_recipeDetailViewModel_recipe_isNotEmpty_ifSuccess() {
        guard let vm = vm else { return }

        vm.selectedMealId = selectedMealId
        
        vm.getRecipe { [weak self] success in
            XCTAssertNotNil(self?.vm?.recipe)
        }
    }

}
