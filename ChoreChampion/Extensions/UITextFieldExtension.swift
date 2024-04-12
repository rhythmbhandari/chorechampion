//
//  UITextFieldExtension.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/12/24.
//

import Foundation
import UIKit

extension UITextField {
    func configureTextField(cornerRadius: CGFloat, borderWidth: CGFloat, textColor: UIColor, borderColor: UIColor, leftPadding: CGFloat, rightPadding: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.textColor = textColor
        setPadding(left: leftPadding, right: rightPadding)
    }

    func setPadding(left: CGFloat, right: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always

        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
}
