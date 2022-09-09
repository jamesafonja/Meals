//
//  MealListViewModel.swift
//  Meals
//
//  Created by Revive on 8/30/22.
//

import Foundation
import SDWebImage

class MealListViewModel {
    private let baseMealsUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    var mealType: MealType? = .beef
    
    var meals = [Meal]() {
        didSet {
            sortedMeals = meals.sorted { $0.strMeal < $1.strMeal }
        }
    }
    
    var sortedMeals = [Meal]()
    
    /// Can be used for debugging or as a message in an alert
    var statusMessage: String = ""
    
    func getMeals(completion: @escaping (_ success: Bool) -> Void) {
        guard let mealType = mealType else {
            return
        }

        let urlString = baseMealsUrl + mealType.rawValue
        
        APIHandler.shared.getData(from: urlString) { [weak self] data, statusMessage in
            self?.statusMessage = statusMessage

            guard let data = data else { return }
            
            do {
                let mealData = try JSONDecoder().decode(MealResponse.self, from: data)
                
                let returnedMeals = mealData.meals
                
                returnedMeals.forEach { meal in
                    if
                        !meal.idMeal.isEmpty,
                        !meal.strMeal.isEmpty,
                        !meal.strMealThumb.isEmpty
                    {
                        self?.meals.append(meal)
                    }
                }
                self?.statusMessage = "MealListViewModel: Successfully retrieved meals"
                completion(true)
            } catch let decoderError {
                self?.statusMessage = "MealListViewModel: \(decoderError)"
                completion(false)
            }
        }
    }
    
    func mealsCount() -> Int {
        return meals.count
    }
    
    func mealAt(row: Int) -> Meal {
        sortedMeals[row]
    }
    
    func navTitleForMealType() -> String {
        if let title = mealType?.rawValue.capitalized {
            return title
        } else {
            return "Meals"
        }

    }
}
