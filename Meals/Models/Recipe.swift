//
//  Rceipe.swift
//  Meals
//
//  Created by Revive on 9/8/22.
//

import Foundation

struct RecipeResponse: Decodable {
    let meals: [[String: String?]]
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

struct Recipe: Decodable {
    let strMealThumb: String?
    let strMeal: String
    let strInstructions: String
    var ingredients = [String]()
        
    init?(data: [[String : String?]]) {
        guard let recipeDict = data.first else { return nil }
        
        self.strMealThumb = recipeDict["strMealThumb"] ?? "No info"
        self.strMeal = recipeDict["strMeal"] as? String ?? "No info"
        self.strInstructions = recipeDict["strInstructions"] as? String ?? "No info"
        
        getIngredients(from: recipeDict)
    }
    
    mutating func getIngredients(from dict: [String: String?]) {
        let ingredientPrefix = "strIngredient"
        let measurePrefix = "strMeasure"
        let ingredientKeys = dict.map { $0.key.hasPrefix(ingredientPrefix) }
                
        for i in 0 ..< ingredientKeys.count {
            let ingredientKey = ingredientPrefix + "\(i)"
            let measureKey = measurePrefix + "\(i)"
            
            if
                let ingredient = dict[ingredientKey] as? String,
                !ingredient.trimmingCharacters(in: .whitespaces).isEmpty
            {
                var ingredientString = ingredient
                
                if let measure = dict[measureKey] as? String {
                    ingredientString = ingredient + ": \(measure)"
                }
                
                self.ingredients.append(ingredientString)
            }
        }
    }
}
