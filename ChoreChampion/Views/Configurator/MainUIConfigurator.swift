//
//  MainUIConfigurator.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/12/24.
//

import Foundation
import UIKit

class MainUIConfigurator {
    func configureNavBar(_ navBar: UINavigationBar?, _ navTitle: UIBarButtonItem?, _ navLogout: UIBarButtonItem?) {
        navBar?.barTintColor = UIColor.primaryColor
        navBar?.isTranslucent = false
        let titleAttribute: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 20, weight: .bold)
                ]
        navTitle?.setTitleTextAttributes(titleAttribute, for: .normal)
        
        let logoutAttribute: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 16, weight: .medium)
                ]
        navLogout?.setTitleTextAttributes(logoutAttribute, for: .normal)
    }
}
