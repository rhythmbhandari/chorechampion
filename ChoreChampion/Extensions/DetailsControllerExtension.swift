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
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let choreType = ChoreType.allCases[row]
        return choreType.description
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedChoreType = ChoreType.allCases[row]
        print("Selected chore type: \(String(describing: selectedChoreType))")
    }
}

//if let isSelected = selectedChoreType {
//    selectedChoreType = isSelected
//}
