//
//  MainViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/28/24.
//

import UIKit

class MainViewController:UIViewController, AddChoreDelegate {
    var authManager: AuthManager?
    var choresManager: ChoresManaging?
    var selectedChore: Chore?
    
    @IBOutlet weak var choreTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authService = FirebaseAuthenticationService()
        authManager = AuthManager(authService: authService)
//        choresManager = InMemoryChoresManager()
        choresManager = UserDefaultsChoresManager()
        
        choreTable.dataSource = self
        choreTable.delegate = self
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
        selectedChore = nil
        self.performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    func choreAdded() {
        DispatchQueue.main.async {
                self.choreTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let destination = segue.destination as! DetailsViewController
            destination.selectedChore = selectedChore
            
            destination.delegate = self
            destination.choresManager = self.choresManager
        }
    }
}

