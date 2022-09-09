//
//  ViewController+Alert.swift
//  Meals
//
//  Created by Revive on 8/31/22.
//

import UIKit

// MARK: UIViewController + Alert
extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
