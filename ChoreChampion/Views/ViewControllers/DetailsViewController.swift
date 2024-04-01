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
    
    @IBOutlet weak var choreTypeSegControl: UISegmentedControl!
    
    @IBOutlet weak var addChoreBtn: UIButton!
    
    @IBOutlet weak var choreDatePicker: UIDatePicker!
    
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
        case ChoreStatus.completed:
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
    
    
    @IBAction func onAddChoreBtnPressed(_ sender: UIButton) {
        sender.isEnabled = false
        showSpinner(for: sender)
        
        if let enteredTitle = titleTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let enteredAssignee = assigneeTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let selectedTypeOfChore = ChoreStatus(rawValue: choreTypeSegControl.selectedSegmentIndex) {
            DispatchQueue.main.async {
                sender.isEnabled = true
                self.hideSpinner(for: sender)                
                //self.choresManager?.addChore(Chore(title: enteredTitle, description: enteredDescription, status: selectedChoreStatus, annotation: enteredAnnotation))

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
        addChoreBtn.isEnabled = !titleTxtField.text!.isEmpty && !assigneeTxtField.text!.isEmpty
    }
    
    func showSpinner(for button: UIButton) {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .systemTeal
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
        button.setTitle("Add", for: .normal)
    }
    
}

