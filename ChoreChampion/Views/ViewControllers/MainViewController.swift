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
        chores.append(Chore(title: "First Chore", description: "First Description", symbol: "square.and.arrow.up.badge.clock.fill", annotation: "First Annotation"))
        
        chores.append(Chore(title: "Second Chore", description: "Second Description", symbol: "􁾛", annotation: "Second Annotation"))
        
        chores.append(Chore(title: "Third Chore", description: "Third Description", symbol: "trash.slash.fill", annotation: "Third Annotation"))
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
    }
}

