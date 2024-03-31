//
//  AddChoreViewController.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/31/24.
//

import UIKit

class AddChoreViewController: UIViewController {
    var choresManager: ChoresManaging?
    var delegate: AddChoreDelegate?

    @IBOutlet weak var titleTxtField: UITextField!
    
    @IBOutlet weak var descTxtField: UITextField!
    
    @IBOutlet weak var annoTxtField: UITextField!
    @IBOutlet weak var titleErrLabel: UILabel!
    @IBOutlet weak var descErrLabel: UILabel!
    
    @IBOutlet weak var annoErrLabel: UILabel!
    @IBOutlet weak var choreStatusSegControl: UISegmentedControl!
    
    @IBOutlet weak var addChoreBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTitleChanged(_ sender: UITextField) {
        guard let newText = sender.text, !newText.isEmpty else {
            toggleError(
                value: true,
                for: titleErrLabel
            )
            return
        }
        
        toggleError(
            value: false,
            for: titleErrLabel
        )
    }
    
    @IBAction func onDescriptionChanged(_ sender: UITextField) {
        guard let newText = sender.text, !newText.isEmpty else {
            toggleError(
                value: true,
                for: descErrLabel
            )
            return
        }
        
        toggleError(
            value: false,
            for: descErrLabel
        )
    }
    
    @IBAction func onAnnotationChanged(_ sender: UITextField) {
        guard let newText = sender.text, !newText.isEmpty else {
            toggleError(
                value: true,
                for: annoErrLabel
            )
            return
        }
        
        toggleError(
            value: false,
            for: annoErrLabel
        )
    }
    
    @IBAction func onAddChoreBtnPressed(_ sender: UIButton) {
        sender.isEnabled = false
        showSpinner(for: sender)
        
        if let enteredTitle = titleTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let enteredDescription = descTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let enteredAnnotation = annoTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let selectedChoreStatus = ChoreStatus(rawValue: choreStatusSegControl.selectedSegmentIndex) {
            DispatchQueue.main.async {
                sender.isEnabled = true
                self.hideSpinner(for: sender)                
                self.choresManager?.addChore(Chore(title: enteredTitle, description: enteredDescription, status: selectedChoreStatus, annotation: enteredAnnotation))

                self.dismiss(animated: true) {
                    self.delegate?.choreAdded()
                }
            }
        }
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func toggleError(
        value: Bool,
        for errorLabel: UILabel
    ) {
        checkAddButtonStatus();
        errorLabel.isHidden = !value
    }
    
    func checkAddButtonStatus() {
        addChoreBtn.isEnabled = !titleTxtField.text!.isEmpty && !descTxtField.text!.isEmpty && !annoTxtField.text!.isEmpty
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
        button.setTitle("Add", for: .normal)
    }
    
}

