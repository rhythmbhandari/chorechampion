//
//  DetailsViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/8/24.
//

import UIKit

class DetailsViewController: UIViewController {
    var choresManager: ChoresManaging?
    var delegate: AddChoreDelegate?
    var selectedChore: Chore?
    var selectedChoreIndex: Int?
    var authManager: AuthManager?
    var currentId: String?
    
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var assigneeTxtField: UITextField!
    
    @IBOutlet weak var titleErrLabel: UILabel!
    @IBOutlet weak var assigneeErrLabel: UILabel!
    @IBOutlet weak var statusOfChoreErrLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var detailsTitleBar: UINavigationItem!
    
    @IBOutlet weak var typeOfChorePicker: UIPickerView!
    
    @IBOutlet weak var choreStatusSegControl: UISegmentedControl!
    
    @IBOutlet weak var addChoreBtn: UIButton!
    
    @IBOutlet weak var choreDatePicker: UIDatePicker!
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    var selectedChoreType: ChoreType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeOfChorePicker.delegate = self
        typeOfChorePicker.dataSource = self
        if let selectedChore = selectedChore {
            titleTxtField.text = selectedChore.title
            assigneeTxtField.text = selectedChore.assignee
            choreStatusSegControl.selectedSegmentIndex = selectedChore.status.rawValue + 1
            selectedChoreType = selectedChore.type
            configureDatePicker(for: selectedChore.status, date: selectedChore.completionDate)
            if let selectedChoreType = selectedChoreType, let selectedIndex = ChoreType.allCases.firstIndex(of: selectedChoreType) {
                typeOfChorePicker.selectRow(selectedIndex, inComponent: 0, animated: false)
                }
            detailsTitleBar.title = "Update Chore"
            addChoreBtn.setTitle("Update", for: .normal)
            checkAddButtonStatus();
            
            deleteBtn.isEnabled = true
        }else{
            configureDatePicker(for: nil, date: nil)
            deleteBtn.isEnabled = false
        }
        
    }
    
    @IBAction func onStatusOfChoreChanged(_ sender: UISegmentedControl) {
        
        guard let type = ChoreStatus(rawValue: sender.selectedSegmentIndex - 1) else{
            dateLabel.text = "Date"
            configureDatePicker(for: nil, date: nil)
            return
        }
        
        switch type {
        case .completed:
            dateLabel.text = "Completed Date"
        default:
            dateLabel.text = "Anticipated Date"
        }
        configureDatePicker(for: type, date: nil)
    }
    
    func configureDatePicker(for status: ChoreStatus?, date: Date?) {
        let currentDate = Date()
        
        let calendar = Calendar.current
        choreDatePicker.datePickerMode = .date
        
        choreDatePicker.minimumDate = calendar.date(byAdding: .year, value: -1, to: currentDate)
        choreDatePicker.maximumDate = calendar.date(byAdding: .year, value: 1, to: currentDate)
        
        if let datePicked = date {
            choreDatePicker.date = datePicked
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
            guard let assigneeTxt = (assigneeTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) else{
                self.showAlert(title: "Assignee", message: "Please enter who completed this task")
                sender.isEnabled = true
                return
            }
            if(assigneeTxt.isEmpty){
                self.showAlert(title: "Assignee", message: "Please enter who completed this task")
                sender.isEnabled = true
                return
            }
        }
        
        guard selectedChoreType != nil else{
            self.showAlert(title: "Type of Chore", message: "Please choose the type of chore")
            sender.isEnabled = true
            return
        }
        
        if let enteredTitle = titleTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let choreType = selectedChoreType{
            DispatchQueue.main.async {
                sender.isEnabled = true
                if let selectedChore = self.selectedChore, let index = self.selectedChoreIndex {
                    let newChore = Chore(id: selectedChore.id, title: enteredTitle, status: selectedStatusOfChore, type: choreType, assignee: self.assigneeTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines), completionDate: self.choreDatePicker.date)
                    self.choresManager?.updateChore(at: index, chore: newChore)
                }else{
                    let newChore = Chore(id: UUID().uuidString, title: enteredTitle, status: selectedStatusOfChore, type: choreType, assignee: self.assigneeTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines), completionDate: self.choreDatePicker.date)
                    self.choresManager?.addChore(newChore)
                }
               
                self.dismiss(animated: true) {
                    self.delegate?.modifyChores()
                }
            }
        }
    }
    
    
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDeleteBtnPressed(_ sender: Any) {
        if let index = selectedChoreIndex {
            self.choresManager?.deleteChore(at: index)
            self.dismiss(animated: true) {
                self.delegate?.modifyChores()
            }
        }
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



/*
Code to add Chore to API
 
 if let _ = self.selectedChore, let index = self.selectedChoreIndex {
                    self.choresManager?.updateChore(at: index, chore: newChore)
                }else{
                 addChore(newChore)
                }
 
 func addChore(_ chore: Chore) {
     authManager?.getToken { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .success(let token):
             
//                print("New Token is \(token)")
             NetworkManager.addTask(authToken: token, task: convertChoreToAPITask(chore)) { error in
                 DispatchQueue.main.async {
                     if let error = error {
                         self.showAlert(title: "Error", message: "Failed to add chore: \(error.localizedDescription)")
                     } else {
                         self.choresManager?.addChore(chore)
                         self.dismiss(animated: true) {
                             self.delegate?.modifyChores()
                         }
                     }
                 }
             }
             
         case .failure(let error):
             print("Error fetching user token: \(error)")
         }
     }

     
 }
 
 func convertChoreToAPITask(_ chore: Chore) -> ResponseChore {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd"

     return ResponseChore(assignee: chore.assignee, dateCompleted: dateFormatter.string(from: chore.completionDate ?? Date()), name: chore.title, status: chore.status.rawValue, taskType: chore.type.rawValue + 1)
 }
 */
