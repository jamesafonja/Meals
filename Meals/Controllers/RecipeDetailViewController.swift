//
//  MealDetailViewController.swift
//  Meals
//
//  Created by Revive on 8/30/22.
//

import UIKit

// MARK: - RecipeDetailViewController
class RecipeDetailViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    // Loading View
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // View Model
    var vm: RecipeDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        showLoadingView()
        getRecipe()
    }
        
}

// MARK: Networking functions
extension RecipeDetailViewController {
    private func getRecipe() {
        vm?.getRecipe(completion: { [weak self] success in
            DispatchQueue.main.async {
                self?.hideLoadingView()
                
                if success {
                    self?.configureViews()
                } else {
                    self?.showAlert(title: "Oh oh", message: self?.vm?.statusMessage)
                }
            }
        })
    }

}

// MARK: View functions
extension RecipeDetailViewController {

    private func configureViews() {
        guard
            let vm = vm,
            let recipe = vm.recipe
        else {
            print("VM IN RECIPE DETAIL IS NIL")
            return
        }
        
        print("VM EXISTS IN RECIPE DETAIL VC")

        if
            let urlString = recipe.strMealThumb,
            let url = URL(string: urlString)
        {
            mealImageView.sd_setImage(with: url, placeholderImage: nil)
        }

        mealNameLabel.text = recipe.strMeal
        ingredientsLabel.text = recipe.ingredients.joined(separator: "\n")
        instructionsLabel.text = recipe.strInstructions
    }
    
    private func showLoadingView() {
        loadingView.isHidden = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingView() {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}
