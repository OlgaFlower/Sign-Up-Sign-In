//
//  SignInViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!

    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var errorNameRedLine: UIView!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var passTitleLabel: UILabel!
    @IBOutlet weak var inputPassTextField: UITextField!
    @IBOutlet weak var errorPassRedLineView: UIView!
    @IBOutlet weak var passErrorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    let presenter = AuthPresenter()
    let defaults = UserDefaults.standard
    var namePassDict = [String : String]() //user logIn data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //restore user data from userDefaults
        if let restoredNamePassDict = defaults.dictionary(forKey: "namePassDict") as? [String : String] {
            namePassDict = restoredNamePassDict
        }
        print("logIn: \(namePassDict)")
        
        presenter.setScreenButton(loginButton, "CONFIRM")
        welcomeLabel.text = "Welcome back"
        createAccountLabel.text = "Don't have an account?"
        signUpButton.setTitle("Sign Up", for: .normal)
        
        inputNameTextField.delegate = self as? UITextFieldDelegate
        inputPassTextField.delegate = self as? UITextFieldDelegate
    
        //add observers for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    //MARK: - Hide error marks
       func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == inputNameTextField {
               presenter.hideRequiredField(nameTitleLabel, RegistrationForm.name.rawValue)
               presenter.hideError(nameErrorLabel, errorNameRedLine)
           }
           if textField == inputPassTextField {
               presenter.hideRequiredField(passTitleLabel, RegistrationForm.pass.rawValue)
               presenter.hideError(passErrorLabel, errorPassRedLineView)
           }
       }
    
    //MARK: - Show/hide keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        presenter.showKeyboard(notification, self)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        presenter.hideKeyboard(notification, self)
    }

    //MARK: - Actions
    @IBAction func confirmLogin(_ sender: Any) {
        guard let name = inputNameTextField.text else { return }
        guard let pass = inputPassTextField.text else { return }
        
        if presenter.checkNameForExisting(namePassDict, name) {
            if pass == namePassDict[name] {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LogedInViewController") as! LogedInViewController
                show(vc, sender: self)
            } else {
                UIView.animate(withDuration: 0.25, animations: {
                    self.presenter.showError(self.passErrorLabel, self.errorPassRedLineView)
                    self.passErrorLabel.text = ValidationErrors.incorrectPass.rawValue
                })
            }
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.presenter.showError(self.nameErrorLabel, self.errorNameRedLine)
                self.nameErrorLabel.text = ValidationErrors.nameNotExist.rawValue
            })
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.show(vc, sender: self)
    }
}

extension SignInViewController: UITextFieldDelegate {
    //hide keyboard by click on "done"/"return" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
