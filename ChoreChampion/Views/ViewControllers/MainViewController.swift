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
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Assuming your storyboard name is "Main"
            if let addChoreVC = storyboard.instantiateViewController(withIdentifier: "AddChoreViewController") as? AddChoreViewController {
                addChoreVC.modalPresentationStyle = .overCurrentContext // Adjust presentation style as needed
                
                // You can pass any necessary data to the AddChoreViewController here if needed
                
                present(addChoreVC, animated: true, completion: nil)
            }
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
