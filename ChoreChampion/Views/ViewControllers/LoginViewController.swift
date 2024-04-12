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
        configureUI()
    }
    
    private func configureUI() {
        emailTxtField.configureTextField(cornerRadius: 16, borderWidth: 1, textColor: UIColor.darkGreyLabelColor, borderColor: UIColor.customCreamColor, leftPadding: 10, rightPadding: 10)
        passTxtField.configureTextField(cornerRadius: 16, borderWidth: 1, textColor: UIColor.darkGreyLabelColor,borderColor: UIColor.customCreamColor, leftPadding: 10, rightPadding: 10)
        loginBtn.layer.cornerRadius = 16
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
        spinner.color = UIColor.primaryColor
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

extension UITextField {

    func configureTextField(cornerRadius: CGFloat, borderWidth: CGFloat, textColor: UIColor, borderColor: UIColor, leftPadding: CGFloat, rightPadding: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.textColor = textColor
        setPadding(left: leftPadding, right: rightPadding)
    }

    func setPadding(left: CGFloat, right: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always

        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
}

extension UIColor {
    static let customCreamColor = UIColor(red: 245/255.0, green: 240/255.0, blue: 232/255.0, alpha: 1)
    static let darkGreyLabelColor = UIColor(red: 112/255.0, green: 112/255.0, blue: 112/255.0, alpha: 1)
    static let primaryColor = UIColor(red: 253/255.0, green: 165/255.0, blue: 55/255.0, alpha: 1)
    static let secondaryColor = UIColor(red: 20/255.0, green: 113/255.0, blue: 226/255.0, alpha: 1)
}
