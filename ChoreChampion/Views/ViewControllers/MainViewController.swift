//
//  MainViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/28/24.
//

import UIKit

class MainViewController:UIViewController {
    var authManager: AuthManager?

    var chores: [Chore] = []
    
    @IBOutlet weak var choreTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authService = FirebaseAuthenticationService()
        authManager = AuthManager(authService: authService)
        loadDefaultChores()
        choreTable.dataSource = self
    }
    
    private func loadDefaultChores() {
        chores.append(Chore(title: "First Chore", description: "First Description", status: TaskStatus.completed, annotation: "First Annotation"))
        
        chores.append(Chore(title: "Second Chore", description: "Second Description", status: TaskStatus.inProgress, annotation: "Second Annotation"))
        
        chores.append(Chore(title: "Third Chore", description: "Third Description", status:  TaskStatus.notStarted, annotation: "Third Annotation"))
    }
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        authManager?.signOut { result in
            switch result {
            case .success():
                return
            case .failure(let error):
                self.showAlert(title: "Login Failed", message: error.localizedDescription)
            }
        }
        
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add Chore", message: "Enter your chore, description, and status", preferredStyle: .alert)
                
        alert.addTextField { textField in
                textField.placeholder = "Enter chore"
            }
            alert.addTextField { textField in
                textField.placeholder = "Enter description of chore"
            }
            
            let containerView = UIView()
           
           let pickerView = UIPickerView()
           pickerView.dataSource = self
           pickerView.delegate = self
           containerView.addSubview(pickerView)
           
           alert.view.addSubview(containerView)
           
           containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
               containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
               containerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
               containerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
               pickerView.topAnchor.constraint(equalTo: alert.textFields!.last!.bottomAnchor, constant: 8),
               pickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
               pickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
               pickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
           ])
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
                    if let titleTxtField = alert.textFields?[0], let descTxtField = alert.textFields?[1] {
                        let title = titleTxtField.text ?? ""
                        let desc = descTxtField.text ?? ""
                        
                        let selectedStatusRow = pickerView.selectedRow(inComponent: 0)
                        let selectedStatus = TaskStatus.allCases[selectedStatusRow]
                        
                        let chore = Chore(title: title, description: desc, status: selectedStatus, annotation: "String")
                        
                    }
                }))
                
                present(alert, animated: true)
            }
}

extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TaskStatus.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TaskStatus.allCases[row].rawValue 
    }
}
