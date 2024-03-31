//
//  UIViewContollerExtension.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}


