//
//  MealListViewController.swift
//  Meals
//
//  Created by Revive on 8/30/22.
//

import UIKit

// MARK: - MealListViewController
class MealListViewController: UIViewController {
    
    @IBOutlet weak var mealsTableView: UITableView!
    
    let vm = MealListViewModel()
    
    private let showRecipeDetailVC = "showRecipeDetailVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = vm.navTitleForMealType()
        
        mealsTableView.register(UINib(nibName: MealCell.id, bundle: nil), forCellReuseIdentifier: MealCell.id)
        
        getMeals()
    }

}

// MARK: - Network functions
extension MealListViewController {
    func getMeals() {
        vm.getMeals() { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.mealsTableView.reloadData()
                }
            } else {
                self?.showAlert(title: "Yikes!", message: self?.vm.statusMessage)
            }
        }
    }
}

// MARK: Segue
extension MealListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showRecipeDetailVC {
            guard
                let row = mealsTableView.indexPathForSelectedRow?.row,
                let recipeDetailVC = segue.destination as? RecipeDetailViewController
            else { return }
            
            let recipeDetailVM = RecipeDetailViewModel()
            let selectedMeal = vm.mealAt(row: row)
            recipeDetailVM.selectedMealId = selectedMeal.idMeal
            recipeDetailVC.vm = recipeDetailVM
        }
    }
}

// MARK: MealListViewController - UITableViewDataSource & UITableViewDelegate functions
extension MealListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.mealsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.id, for: indexPath) as? MealCell else {
            return UITableViewCell()
        }
        
        let meal = vm.mealAt(row: indexPath.row)
        
        cell.primaryLabel.text = meal.strMeal
        
        if let url = URL(string: meal.strMealThumb) {
            cell.cellImageView.sd_setImage(with: url, placeholderImage: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MealCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: showRecipeDetailVC, sender: self)
    }
    
}
