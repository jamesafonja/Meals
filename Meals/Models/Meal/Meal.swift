//
//  Meal.swift
//  Meals
//
//  Created by Revive on 9/8/22.
//

import Foundation

struct MealResponse: Decodable {
    let meals: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
}
