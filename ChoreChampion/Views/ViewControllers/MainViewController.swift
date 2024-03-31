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
        chores.append(Chore(title: "First Chore", description: "First Description", status: ChoreStatus.completed, annotation: "First Annotation"))
        
        chores.append(Chore(title: "Second Chore", description: "Second Description", status: ChoreStatus.inProgress, annotation: "Second Annotation"))
        
        chores.append(Chore(title: "Third Chore", description: "Third Description", status:  ChoreStatus.notStarted, annotation: "Third Annotation"))
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
        let storyboard = UIStoryboard(name: "AddChore", bundle: nil)
        if let addChoreVC = storyboard.instantiateViewController(withIdentifier: "AddChoreViewController") as? AddChoreViewController {
            addChoreVC.modalPresentationStyle = .overCurrentContext
            
            present(addChoreVC, animated: true, completion: nil)
        }
    }
    
}

