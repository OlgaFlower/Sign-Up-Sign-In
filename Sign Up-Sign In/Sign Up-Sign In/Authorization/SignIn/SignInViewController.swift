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
    @IBOutlet weak var showHideButton: UIButton!
    
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
    
    let authPresenter = AuthPresenter()
    let presenter = SignInPresenter()
    
    var passIsHidden = false
    let defaults = UserDefaults.standard
    var lastUser = [String : String]() //last logged in
    var loggedInCondition = false
    var usersBase = [String : String]() //all registered users
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.disableTextfieldAutocorrection()
        inputPassTextField.isSecureTextEntry = true
        showHideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        presenter.signInVC = self
        
        //restore lastUser data from userDefaults
        if let user = defaults.dictionary(forKey: "lastUser") as? [String : String] {
            lastUser = user
        }
        
        if let condition = defaults.bool(forKey: "loggedInCondition") as? Bool {
            loggedInCondition = condition
        }
        
        authPresenter.setRoundedButton(loginButton, "CONFIRM")
        signUpButton.setTitle("Sign Up", for: .normal)
        
        inputNameTextField.delegate = self
        inputPassTextField.delegate = self
    
        //add observers for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set nav bar transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //change the bar style to black-translucent
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        //hide bottom nav bar separator
        navigationController?.navigationBar.shadowImage = UIImage()
        //delete "back" title 
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //set back button
        let backImg = UIImage(named: "back.png")
        self.navigationController?.navigationBar.backIndicatorImage = backImg
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImg
        //set nav bar font
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans W3", size: 14)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        presenter.setLabels()
        
        //check if was user logged out
        if let condition = defaults.bool(forKey: "loggedInCondition") as? Bool {
            loggedInCondition = condition
            guard let name = lastUser.keys.first else { return }
            
            if condition == true {
                inputNameTextField.text = name
                inputPassTextField.text = lastUser[name]
            } else {
                inputPassTextField.text = ""
                inputNameTextField.text = ""
            }
        }
    }
    
    //MARK: - Hide error marks
       func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == inputNameTextField {
               authPresenter.hideRequiredField(nameTitleLabel, RegistrationForm.name.rawValue)
               authPresenter.hideError(nameErrorLabel, errorNameRedLine)
           }
           if textField == inputPassTextField {
               authPresenter.hideRequiredField(passTitleLabel, RegistrationForm.pass.rawValue)
            authPresenter.hideError(passErrorLabel, errorPassRedLineView)
        }
    }
    
    //MARK: - Show/hide keyboard
    //hide keyboard by tap out of text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        authPresenter.showKeyboard(notification, self)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        authPresenter.hideKeyboard(notification, self)
    }

    //MARK: - Actions
    //Show/Hide password
    @IBAction func showHidePasswordButton(_ sender: Any) {
        if passIsHidden == false {
            inputPassTextField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            inputPassTextField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        passIsHidden = !passIsHidden
    }
    
    //Confirm Login
    @IBAction func confirmLogin(_ sender: Any) {
        guard inputNameTextField.text != nil else { return }
        
        if presenter.isLoginTextFieldsEmpty() == false {
            
            if loggedInCondition == true && presenter.checkInputsForEquivWithSavedData() == true {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LogedInViewController") as! LogedInViewController
                show(vc, sender: self)
            }
            else {
                guard let name = inputNameTextField.text else { return }
                guard let pass = inputPassTextField.text else { return }
                
                //restore user base
                if let base = defaults.dictionary(forKey: "usersBase") as? [String : String] {
                    usersBase = base
                }
                
                //if user exist in the base
                if authPresenter.checkNameForExisting(usersBase, name) {
                    
                    //if pass is equal
                    if pass == usersBase[name] {
                        loggedInCondition = true
                        lastUser = [name : pass]
                        //save to userDefaults
                        defaults.set(self.loggedInCondition, forKey: "loggedInCondition")
                        defaults.set(self.lastUser, forKey: "lastUser")
                        
                        let vc = storyboard?.instantiateViewController(withIdentifier: "LogedInViewController") as! LogedInViewController
                        show(vc, sender: self)
                    } else {
                        //if passwords arn't equal
                        UIView.animate(withDuration: 0.25, animations: {
                            self.authPresenter.showError(self.passErrorLabel, self.errorPassRedLineView)
                            self.passErrorLabel.text = ValidationErrors.incorrectPass.rawValue
                        })
                    }
                } else {
                    //if user doesn't exist in the base
                    UIView.animate(withDuration: 0.25, animations: {
                        self.authPresenter.showError(self.nameErrorLabel, self.errorNameRedLine)
                        self.nameErrorLabel.text = ValidationErrors.nameNotExist.rawValue
                    })
                }
            }
        }
    }
    
    //Create account
    @IBAction func createAccount(_ sender: Any) {
        presenter.hideAllErrorsIfSignUpButtonTapped()
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.show(vc, sender: self)
    }
}

//MARK: - SignIn extension
extension SignInViewController: UITextFieldDelegate {
    //hide keyboard by click on "done"/"return" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
