//
//  MealCell.swift
//  Meals
//
//  Created by Revive on 8/30/22.
//
 
import UIKit

class MealCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var primaryLabel: UILabel!
    
    static let id = "MealCell"
    static let cellHeight: CGFloat = 100

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
