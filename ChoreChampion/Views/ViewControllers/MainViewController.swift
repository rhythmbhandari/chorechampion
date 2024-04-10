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
    var selectedChoreIndex: Int?
    
    @IBOutlet weak var choreTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthentication()
        setupTableView()
    }
    
    private func setupAuthentication() {
        let authService = FirebaseAuthenticationService()
        authManager = AuthManager(authService: authService)
        choresManager = UserDefaultsChoresManager()
        authManager?.getToken { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                self.fetchChores(with: token)
            case .failure(let error):
                print("Error fetching user token: \(error)")
            }
        }
    }
    
    private func fetchChores(with authToken: String) {
        NetworkManager.fetchChores(authToken: authToken)
        { chores, error in
            if let error = error {
                print("Error fetching chores: \(error)")
            } else if let chores = chores {
                self.addFetchedChores(chores)
                self.modifyChores()
            }
        }

    }
    
    private func addFetchedChores(_ chores: [Chore]) {
        choresManager?.addChores(chores)
        for chore in chores {
            print(chore)
        }
    }
    
    private func setupTableView() {
        choreTable.dataSource = self
        choreTable.delegate = self
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
    
    func modifyChores() {
        DispatchQueue.main.async {
            self.choreTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let destination = segue.destination as! DetailsViewController
            destination.selectedChore = selectedChore
            destination.selectedChoreIndex = selectedChoreIndex
            destination.delegate = self
            destination.choresManager = self.choresManager
        }
    }
}

