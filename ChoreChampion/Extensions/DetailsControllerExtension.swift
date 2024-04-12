//
//  DetailsControllerExtension.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/1/24.
//

import Foundation
import UIKit

extension DetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ChoreType.allCases.count
    }
}

extension DetailsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let label = (view as? UILabel) ?? UILabel()
            label.textAlignment = .center
            let choreType = ChoreType.allCases[row]

            label.text = choreType.description

                if row == pickerView.selectedRow(inComponent: component) {
                    label.textColor = UIColor.white
                    label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
                    label.backgroundColor = UIColor.secondaryColor
                } else {
                    label.textColor = UIColor.gray
                    label.font = UIFont.systemFont(ofSize: 18)
                }
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            return label
        }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedChoreType = ChoreType.allCases[row]
        print("Selected chore type: \(String(describing: selectedChoreType))")
        pickerView.reloadAllComponents()
    }
}

//if let isSelected = selectedChoreType {
//    selectedChoreType = isSelected
//}
