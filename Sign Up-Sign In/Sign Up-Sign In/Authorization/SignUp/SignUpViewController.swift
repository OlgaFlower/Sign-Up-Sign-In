//
//  SignUpViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
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
    
    let presenter = AuthPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.signUpVC = self
        inputEmailTextField.delegate = self
        inputNameTextField.delegate = self
        inputPassTextField.delegate = self
        presenter.setScreenButton(confirmRegistrationButton, "CONFIRM")
        
        inputEmailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        inputNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        inputPassTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        inputConfirmPassTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        //add observers for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setNavBar(self)
    }
    
    
    
    
    
    
    @IBAction func confirmRegistration(_ sender: Any) {
        if presenter.checkPass(inputPassTextField, passTitleLabel, firstPassErrorLabel, firstPassErrorLine) == true {
            self.navigationController?.popViewController(animated: true)
        } else { return }
    }
    
    
    
    
    //MARK: - Handle keyboard
    //hide keyboard by tap out of text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        presenter.showKeyboard(notification, self)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        presenter.hideKeyboard(notification, self)
    }
    
    //MARK: - Validation
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == inputPassTextField {
            presenter.hideRequiredField(passTitleLabel)
            presenter.hideError(firstPassErrorLabel, firstPassErrorLine)
        }
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
//        let minLength = 5
//        var emailIsValid = false
//        var passIsValid = false
//        var passwordsAreEqual = false
//        var nameIsValid = false
//
//        if inputEmailTextField.text!.count >= minLength {
//            if Validation.emailValidator(inputEmailTextField.text!) == true {
//                emailIsValid = true
//            }
//        }
//
//        if inputNameTextField.text!.count >= 5 {
//            if Validation.nameValidator(inputNameTextField.text!) == true {
//                nameIsValid = true
//            }
//        }
//
//        if inputPassTextField.text!.count >= minLength {
//            if Validation.passValidator(inputPassTextField.text!) == true {
//                passIsValid = true
//            }
//        }
//
//        if passIsValid, inputConfirmPassTextField.text == inputPassTextField.text {
//            passwordsAreEqual = true
//        }
        
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
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "@" + presenter.restrictedSymbols)) == nil
        }
    
    
    
    
        //MARK: - Prevent input restricted symbols
        func preventInputRestrictedSymbols(_ string: String, _ textField: UITextField) -> Bool {
            switch textField {
            case inputEmailTextField:
                return string.rangeOfCharacter(from: CharacterSet(charactersIn: presenter.restrictedSymbols)) == nil
            case inputNameTextField:
                return string.rangeOfCharacter(from: CharacterSet(charactersIn: presenter.restrictedSymbols)) == nil
            case inputPassTextField:
                return string.rangeOfCharacter(from: CharacterSet(charactersIn: "." + presenter.restrictedSymbols)) == nil
            case inputConfirmPassTextField:
                return string.rangeOfCharacter(from: CharacterSet(charactersIn: "." + presenter.restrictedSymbols)) == nil
            default:
                return false
            }
        }
    
}
