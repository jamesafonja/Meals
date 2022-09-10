//
//  MealListViewModelTests.swift
//  MealsTests
//
//  Created by Revive on 9/9/22.
//

import XCTest
@testable import Meals

class MealListViewModelTests: XCTestCase {
    var vm: MealListViewModel?
    
    override func setUpWithError() throws {
        vm = MealListViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
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
        guard let vm = vm else { return }
                
        vm.getMeals(ofType: .dessert) { success in
            XCTAssertTrue(success)
        }
    }
    
    func test_mealListViewModel_statusMessage_isNotEmptyAfterRunning() {
        guard let vm = vm else { return }

        vm.getMeals(ofType: .dessert) { [weak self] _ in
            guard let statusMessage = self?.vm?.statusMessage else { return }
            XCTAssertTrue(!statusMessage.isEmpty)
        }
    }
    
    func test_mealListViewModel_meals_isEmpty_OnInit() {
        guard let vm = vm else { return }

        vm.getMeals(ofType: .dessert) { [weak self] success in
            if success {
                guard let meals = self?.vm?.meals else { return }
                XCTAssertTrue(meals.isEmpty)
            }
        }
    }
    
    func test_mealListViewModel_meals_isNotEmpty_ifSuccess() {
        guard let vm = vm else { return }

        vm.getMeals(ofType: .dessert) { [weak self] success in
            if success {
                guard let meals = self?.vm?.meals else { return }
                XCTAssertTrue(meals.count > 0)
            }
        }
    }
}
