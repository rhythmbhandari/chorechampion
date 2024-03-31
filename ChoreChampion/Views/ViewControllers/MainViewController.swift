//
//  MainViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/28/24.
//

import UIKit

class MainViewController:UIViewController {
    var authManager: AuthManager?
    var choresManager: ChoresManaging?
    
    @IBOutlet weak var choreTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authService = FirebaseAuthenticationService()
        authManager = AuthManager(authService: authService)
        choresManager = InMemoryChoresManager()
        choreTable.dataSource = self
        choreTable.reloadData()
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

