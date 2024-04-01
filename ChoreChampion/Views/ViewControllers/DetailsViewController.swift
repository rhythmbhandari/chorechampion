//
//  AddChoreViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/31/24.
//

import UIKit

class DetailsViewController: UIViewController {
    var choresManager: ChoresManaging?
    var delegate: AddChoreDelegate?

    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var assigneeTxtField: UITextField!
    @IBOutlet weak var annoTxtField: UITextField!
    
    @IBOutlet weak var titleErrLabel: UILabel!
    @IBOutlet weak var assigneeErrLabel: UILabel!
    @IBOutlet weak var statusOfChoreErrLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var typeOfChorePicker: UIPickerView!
    
    @IBOutlet weak var choreStatusSegControl: UISegmentedControl!
    
    @IBOutlet weak var addChoreBtn: UIButton!
    
    @IBOutlet weak var choreDatePicker: UIDatePicker!
    
    var selectedChoreType: ChoreType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeOfChorePicker.delegate = self
        typeOfChorePicker.dataSource = self
        configureDatePicker(for: nil)
    }
    
    @IBAction func onStatusOfChoreChanged(_ sender: UISegmentedControl) {
        
        guard let type = ChoreStatus(rawValue: sender.selectedSegmentIndex - 1) else{
            dateLabel.text = "Date"
            configureDatePicker(for: nil)
            return
        }
        
        switch type {
        case .completed:
            dateLabel.text = "Completed Date"
        default:
            dateLabel.text = "Anticipated Date"
        }
        configureDatePicker(for: type)
    }
    
    func configureDatePicker(for status: ChoreStatus?) {
        let currentDate = Date()
        let calendar = Calendar.current
        choreDatePicker.datePickerMode = .date

        guard let status = status else {
//            choreDatePicker.isEnabled = false
            return
        }
        
//        choreDatePicker.isEnabled = true
        
        switch status {
        case .completed:
            choreDatePicker.maximumDate = currentDate
            choreDatePicker.minimumDate = calendar.date(byAdding: .year, value: -1, to: currentDate)
            
        default:
            choreDatePicker.minimumDate = currentDate
            choreDatePicker.maximumDate = calendar.date(byAdding: .year, value: 1, to: currentDate)
        }
        
    }
    
    @IBAction func onTitleChanged(_ sender: UITextField) {
        guard let newText = sender.text, !newText.isEmpty else {
            toggleError(
                value: true,
                for: titleErrLabel
            )
            return
        }
        
        toggleError(
            value: false,
            for: titleErrLabel
        )
    }
    
    @IBAction func onAssigneeChanged(_ sender: UITextField) {
        guard let status = ChoreStatus(rawValue: choreStatusSegControl.selectedSegmentIndex - 1 ) else {
            return
        }
        if(status == .completed){
            guard let newText = sender.text, !newText.isEmpty else {
                toggleError(
                    value: true,
                    for: assigneeErrLabel
                )
                return
            }
            
            toggleError(
                value: false,
                for: assigneeErrLabel
            )
        }
    }
    
    
    @IBAction func onAddChoreBtnPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        guard let selectedStatusOfChore = ChoreStatus(rawValue: choreStatusSegControl.selectedSegmentIndex - 1 ) else{
            self.showAlert(title: "Status of Chore", message: "Please select a status other than Not Stated.")
            
            sender.isEnabled = true
            return
        }
        
        if(selectedStatusOfChore == .completed){
            guard (assigneeTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) != nil else{
                self.showAlert(title: "Assignee", message: "Please enter who completed this task")
                sender.isEnabled = true
                return
            }
        }
        
        
        
        if let enteredTitle = titleTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let selectedTypeOfChore = selectedChoreType{
            DispatchQueue.main.async {
                sender.isEnabled = true
                print("")
                self.choresManager?.addChore(Chore(id: UUID().uuidString, title: enteredTitle, status: selectedStatusOfChore, type: selectedTypeOfChore, assignee: self.assigneeTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines), completionDate: self.choreDatePicker.date, detailsAnnotation: self.annoTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)))

                self.dismiss(animated: true) {
                    self.delegate?.choreAdded()
                }
            }
        }
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
        
    func toggleError(
        value: Bool,
        for errorLabel: UILabel
    ) {
        checkAddButtonStatus();
        errorLabel.isHidden = !value
    }
    
    func checkAddButtonStatus() {
        addChoreBtn.isEnabled = !titleTxtField.text!.isEmpty
    }
    
    
}

