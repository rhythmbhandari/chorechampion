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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addChoreVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {            
            addChoreVC.delegate = self
            addChoreVC.choresManager = self.choresManager
            addChoreVC.modalPresentationStyle = .overCurrentContext
            present(addChoreVC, animated: true, completion: nil)
        }
    }
    
    func choreAdded() {
        DispatchQueue.main.async {
                self.choreTable.reloadData()
        }
    }
}

