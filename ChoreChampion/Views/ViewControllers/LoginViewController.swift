//
//  ViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/26/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    
    @IBOutlet weak var emailErrLabel: UILabel!
    @IBOutlet weak var passErrLabel: UILabel!
    
    var authManager: AuthManager!

    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authService = FirebaseAuthenticationService()
        authManager = AuthManager(authService: authService)
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
        showSpinner(for: sender)
        
        if let enteredEmail = emailTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let enteredPassword = passTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            let credentials = Credentials(email: enteredEmail, password: enteredPassword)
            authManager?.signIn(with: credentials) { [weak self] result in
                
                DispatchQueue.main.async {
                    sender.isEnabled = true
                    self?.hideSpinner(for: sender)
                    
                    switch result {
                    case .success():
                        return
                    case .failure(let error):
                        self?.showAlert(title: "Login Failed", message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func showSpinner(for button: UIButton) {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .systemTeal
        spinner.startAnimating()
        button.addSubview(spinner)
        spinner.center = CGPoint(x: button.bounds.width / 2, y: button.bounds.height / 2)
        button.setTitle("", for: .normal)
    }
    
    func hideSpinner(for button: UIButton) {
        button.subviews.compactMap { $0 as? UIActivityIndicatorView }.forEach {
            $0.stopAnimating()
            $0.removeFromSuperview()
        }
        button.setTitle("Login", for: .normal)
    }
    
    
    func navigateToMainViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController")
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        
        sceneDelegate.window?.rootViewController = mainViewController
    }
    
}


