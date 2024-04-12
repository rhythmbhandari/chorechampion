//
//  DetailsUIConfigurator.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/12/24.
//

import Foundation
import UIKit

class DetailsUIConfigurator {    
    func configureNavBar(_ navBar: UINavigationBar) {
        navBar.barTintColor = UIColor.primaryColor
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
    }
    
    func configureTextFields(_ titleTxtField: UITextField?, _ assigneeTxtField: UITextField?) {
        let textFields = [titleTxtField, assigneeTxtField]
        let cornerRadius: CGFloat = 16
        let borderWidth: CGFloat = 1
        let padding: CGFloat = 10
        
        for textField in textFields {
            textField?.configureTextField(
                cornerRadius: cornerRadius,
                borderWidth: borderWidth,
                textColor: UIColor.darkGreyLabelColor,
                borderColor: UIColor.customCreamColor,
                leftPadding: padding,
                rightPadding: padding
            )
        }
    }
    
    func configureSegmentedControl(_ choreStatusSegControl: UISegmentedControl?) {
        choreStatusSegControl?.layer.cornerRadius = 16.0
        choreStatusSegControl?.layer.masksToBounds = true
        choreStatusSegControl?.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white],
            for: .selected
        )
        choreStatusSegControl?.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.darkGreyLabelColor],
            for: .normal
        )
    }
}
