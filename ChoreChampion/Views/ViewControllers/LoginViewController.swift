//
//  ViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/26/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    
    @IBOutlet weak var emailErrLabel: UILabel!
    @IBOutlet weak var passErrLabel: UILabel!
    var spinner: UIActivityIndicatorView?

    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onEmailChanged(_ sender: UITextField) {
        
            guard let newText = sender.text, !newText.isEmpty else {
                toggleError(
                    value: true,
                    for: emailErrLabel
                )
                return
            }
            
            toggleError(
                value: false,
                for: emailErrLabel
            )
    }
    
    
    @IBAction func onPassChanged(_ sender: UITextField) {
        guard let newText = sender.text, !newText.isEmpty else {
            toggleError(
                value: true,
                for: passErrLabel
            )
            return
        }
        
        toggleError(
            value: false,
            for: passErrLabel
        )
    }
    
    func toggleError(
        value: Bool,
        for errorLabel: UILabel
    ) {
        checkLoginButtonStatus();
        errorLabel.isHidden = !value
    }
    
    
    func checkLoginButtonStatus() {
        loginBtn.isEnabled = !emailTxtField.text!.isEmpty && !passTxtField.text!.isEmpty
    }
    
    
    @IBAction func onLoginBtnPressed(_ sender: UIButton) {
        sender.isEnabled = false
        spinner = UIActivityIndicatorView(style: .medium)
        spinner?.color = .systemTeal
        spinner?.startAnimating()
        sender.addSubview(spinner!)
        spinner?.center = CGPoint(x: sender.bounds.width / 2, y: sender.bounds.height / 2)
        spinner?.startAnimating()
        
            sender.setTitle("", for: .normal)
            if let enteredEmail = emailTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
               let enteredPassword = passTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                    
                    Auth.auth().signIn(withEmail: enteredEmail, password: enteredPassword) { [weak self] authResult, error in
                        // Re-enable the button
                        sender.isEnabled = true
                        
                        sender.setTitleColor(.white, for: .disabled)
                        
                        
                        // Hide spinner
                        self?.spinner?.stopAnimating()
                        self?.spinner?.removeFromSuperview()
                        self?.spinner = nil
                        
                        if let error = error {
                            self?.showAlert(title: "Login Failed", message: error.localizedDescription)
                            sender.setTitle("Login", for: .normal)
                        } else {
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController")
                            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                                sceneDelegate.window?.rootViewController = mainViewController
                            }
                            sender.setTitle("Login", for: .normal)
                        }
                    
                }}
        
    }
    

    
    struct Credentials: Hashable {
        let email: String
        let password: String
    }
    
    
    func showAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            
        }
        alert.addAction(
            okAction
        )
        present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
}
