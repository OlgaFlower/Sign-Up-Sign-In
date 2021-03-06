//
//  SignUpViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpViewTitle: UILabel!
    
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var inputEmailTextField: UITextField!
    @IBOutlet weak var emailErrorRedLineView: UIView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var nameErrorRedLineView: UIView!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var passTitleLabel: UILabel!
    @IBOutlet weak var inputPassTextField: UITextField!
    @IBOutlet weak var firstPassErrorLine: UIView!
    @IBOutlet weak var firstPassErrorLabel: UILabel!
    
    @IBOutlet weak var confirmPassTitleLabel: UILabel!
    @IBOutlet weak var inputConfirmPassTextField: UITextField!
    @IBOutlet weak var passErrorRedLineView: UIView!
    @IBOutlet weak var passErrorLabel: UILabel!
    
    @IBOutlet weak var confirmRegistrationButton: UIButton!
    
    let authPresenter = AuthPresenter()
    let presenter = SignUpPresenter()
    
    let defaults = UserDefaults.standard
    var lastUser = [String : String]() //the last logged in
    var loggedInCondition = false
    var usersBase = [String : String]() //all registered users
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //restore user data from userDefaults
        if let base = defaults.dictionary(forKey: "usersBase") as? [String : String] {
            usersBase = base
        }
        
        authPresenter.signUpVC = self
        presenter.signUpVC = self
        
        inputEmailTextField.delegate = self
        inputNameTextField.delegate = self
        inputPassTextField.delegate = self
        inputConfirmPassTextField.delegate = self
        
        presenter.disableTextfieldAutocorrection()
        authPresenter.setRoundedButton(confirmRegistrationButton, "CONFIRM")
        
        //add observers for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setLabels()
        authPresenter.setNavBar(self)
    }
    
    //MARK: - Handle keyboard
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
    
    //MARK: - Hide error marks
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == inputEmailTextField {
            authPresenter.hideRequiredField(emailTitleLabel, RegistrationForm.email.rawValue)
            authPresenter.hideError(emailErrorLabel, emailErrorRedLineView)
        }
        if textField == inputNameTextField {
            authPresenter.hideRequiredField(nameTitleLabel, RegistrationForm.name.rawValue)
            authPresenter.hideError(nameErrorLabel, nameErrorRedLineView)
        }
        if textField == inputPassTextField {
            authPresenter.hideRequiredField(passTitleLabel, RegistrationForm.pass.rawValue)
            authPresenter.hideError(firstPassErrorLabel, firstPassErrorLine)
        }
        if textField == inputConfirmPassTextField {
            authPresenter.hideRequiredField(confirmPassTitleLabel, RegistrationForm.confirmPass.rawValue)
            authPresenter.hideError(passErrorLabel, passErrorRedLineView)
        }
    }
    
    @IBAction func confirmRegistration(_ sender: Any) {
        
        if registrationIsValid == true {
            guard let name = inputNameTextField.text else { return }
            guard let pass = inputPassTextField.text else { return }
            
            if authPresenter.checkNameForExisting(lastUser, name) == true {
                authPresenter.showNotificationAboutExistingName()
                return
            } else {
                
//                lastUser = [name : pass]
//                loggedInCondition = true
                usersBase[name] = pass
                
                //save to userDefaults
//                defaults.set(self.lastUser, forKey: "lastUser")
//                defaults.set(self.loggedInCondition, forKey: "loggedInCondition")
                defaults.set(self.usersBase, forKey: "usersBase")
                
                //return to the previous VC
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    private var registrationIsValid: Bool {
        let emptyField = presenter.checkForEmptyTextfield()
        //Check if textFields != nil and validateinput text
        if emptyField == true || authPresenter.checkEmail() == false {
            return false
        }
        if emptyField == true || authPresenter.checkName() == false {
            return false
        }
        if emptyField == true || authPresenter.checkPass() == false {
            return false
        }
        if emptyField == true || authPresenter.checkConfirmPass() == false {
            return false
        }
        return true
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    //MARK: - Handle Done/Return button
    //hide keyboard by click on "done"/"return" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //MARK: - Check email, password for max length & remove restricted symbols
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text, let rangeOfTextToReplace = Range(range, in: textFieldText) else { return false }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        
        switch textField {
            
        case inputEmailTextField:
            guard let email = inputEmailTextField.text else { return false }
            if email.contains("@") {
                return preventRepeatingAtSymbol(string)
            }
            if email.count <= 25 {
                return preventInputRestrictedSymbols(string, textField)
            }
        case inputNameTextField:
            return count <= 20 && preventInputRestrictedSymbols(string, textField)
        case inputPassTextField:
            return count <= 20 && preventInputRestrictedSymbols(string, textField)
        case inputConfirmPassTextField:
            return count <= 20 && preventInputRestrictedSymbols(string, textField)
        default:
            return false
        }
        return true
    }
    
    func preventRepeatingAtSymbol(_ string: String) -> Bool {
        // prevent enter more than one "@" in email field
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "@" + Validation.restrictedSymbols)) == nil
    }
    
    //MARK: - Prevent input restricted symbols
    func preventInputRestrictedSymbols(_ string: String, _ textField: UITextField) -> Bool {
        switch textField {
        case inputEmailTextField:
            return string.rangeOfCharacter(from: CharacterSet(charactersIn: Validation.restrictedSymbols)) == nil
        case inputNameTextField:
            return string.rangeOfCharacter(from: CharacterSet(charactersIn: Validation.restrictedSymbols)) == nil
        case inputPassTextField:
            return string.rangeOfCharacter(from: CharacterSet(charactersIn: "." + Validation.restrictedSymbols)) == nil
        case inputConfirmPassTextField:
            return string.rangeOfCharacter(from: CharacterSet(charactersIn: "." + Validation.restrictedSymbols)) == nil
        default:
            return false
        }
    }
    
}
