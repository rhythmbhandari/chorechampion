//
//  LoginUIConfigurator.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/12/24.
//

import Foundation
import UIKit

class LoginUIConfigurator {
    func configureUI(_ emailTxtField: UITextField, _ passTxtField: UITextField, _ loginBtn: UIButton) {
            emailTxtField.configureTextField(cornerRadius: 16, borderWidth: 1, textColor: UIColor.darkGreyLabelColor, borderColor: UIColor.customCreamColor, leftPadding: 10, rightPadding: 10)
            passTxtField.configureTextField(cornerRadius: 16, borderWidth: 1, textColor: UIColor.darkGreyLabelColor,borderColor: UIColor.customCreamColor, leftPadding: 10, rightPadding: 10)
            loginBtn.layer.cornerRadius = 16
    }
    
    func showSpinner(for button: UIButton) {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = UIColor.primaryColor
        spinner.startAnimating()
        button.addSubview(spinner)
        spinner.center = CGPoint(x: button.bounds.width / 2, y: button.bounds.height / 2)
        button.setTitle("", for: .normal)
    }
    
    func hideSpinner(for button: UIButton) {
        button.subviews.compactMap { $0 as? UIActivityIndicatorView }.forEach {
            $0.stopAnimating()
            $0.removeFromSuperview()
        }
        button.setTitle("Login", for: .normal)
    }
    
}
