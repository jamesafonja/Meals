//
//  RecipeDetailViewModel.swift
//  Meals
//
//  Created by Revive on 9/8/22.
//

import Foundation

class RecipeDetailViewModel {
    let baseRecipeUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var selectedMealId: String?
    var statusMessage: String = "" // For debugging
    var recipe: Recipe?

    func getRecipe(completion: @escaping ((_ success: Bool) -> Void)) {
        guard
            let mealID = selectedMealId
        else { return }
        
        let urlString = baseRecipeUrl + mealID

        APIHandler.shared.getData(from: urlString) { [weak self] data, statusMessage in
            guard let data = data else {
                self?.statusMessage = "RecipeDetailViewModel: No data"
                completion(false)
                return
            }
            
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                self?.recipe = Recipe(data: recipeResponse.meals)
                self?.statusMessage = "RecipeDetailViewModel: Retrieved recipe successfully"
                completion(true)
            } catch let decoderError {
                self?.statusMessage = "RecipeDetailViewModel: Error decoding recipe from data. \(decoderError)"
            }
        }
    }
}
