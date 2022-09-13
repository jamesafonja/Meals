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

        vm?.getRecipe { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.configureViews()
                }
            } else {
                DispatchQueue.main.async {
                    self?.hideLoadingView()
                    self?.showAlert(title: "Error", message: self?.vm?.statusMessage)
                }
            }
        }
    }
        
}

// MARK: View functions
extension RecipeDetailViewController {

    private func configureViews() {
        guard
            let vm = vm,
            let recipe = vm.recipe
        else {
            return
        }
        
        // Set meal thumbnail image
        if
            let urlString = recipe.strMealThumb,
            let url = URL(string: urlString)
        {
            mealImageView.sd_setImage(with: url, placeholderImage: nil)
        }

        // Set text for labels
        mealNameLabel.text = recipe.strMeal
        ingredientsLabel.text = recipe.ingredients.joined(separator: "\n")
        instructionsLabel.text = recipe.strInstructions
        
        // Hide the loading view
        hideLoadingView()
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
