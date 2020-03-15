//
//  AuthPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class AuthPresenter {
    
    weak var signUpVC: SignUpViewController?
    var passwordsAreEqual = false
    
    func setScreenButton(_ button: UIButton, _ title: String) {
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
    }
    
    //transparent navbar
    func setNavBar(_ vc: UIViewController) {
        vc.navigationController?.setNavigationBarHidden(false, animated: true)
        vc.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc.navigationController!.navigationBar.isTranslucent = true
        
    }
    
    //MARK: - Handle soft keyboard
    //show keyboard and scroll view up
    func showKeyboard(_ notification: NSNotification, _ vc: UIViewController) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = keyboardSize.cgRectValue
        if vc.view.frame.origin.y == 0 {
            vc.view.frame.origin.y -= (keyboardFrame.height - 180)
        }
    }
    
    // hide keyboard and scroll view down
    func hideKeyboard(_ notification: NSNotification, _ vc: UIViewController) {
        if vc.view.frame.origin.y != 0 {
            vc.view.frame.origin.y = 0
        }
    }
    
    //MARK: - Check for empty text fields
    func checkForEmptyTextfield() {
        guard let vc = signUpVC else { return }
        if vc.inputEmailTextField.text!.isEmpty {
            self.showRequiredField(vc.emailTitleLabel)
        }
        if vc.inputNameTextField.text!.isEmpty {
            self.showRequiredField(vc.nameTitleLabel)
        }
        if vc.inputPassTextField.text!.isEmpty {
            self.showRequiredField(vc.passTitleLabel)
        }
        if vc.inputConfirmPassTextField.text!.isEmpty {
            self.showRequiredField(vc.confirmPassTitleLabel)
        }
    }
    
    //MARK: - Validation
    
    //Email validation
    func checkEmail() -> Bool {
        guard let vc = signUpVC else { return false }
        guard let text = vc.inputEmailTextField.text else { return false }
        if text.count >= 1 && Validation.emailValidator(text) != "" {
            showError(vc.emailErrorLabel, vc.emailErrorRedLineView)
            vc.emailErrorLabel.text = Validation.emailValidator(text)
            return false
        }
        return true
    }
    
    //Name validation
    func checkName() -> Bool {
        guard let vc = signUpVC else { return false }
        guard let text = vc.inputNameTextField.text else { return false }
        if text.count >= 1 && Validation.nameValidator(text) != "" {
            showError(vc.nameErrorLabel, vc.nameErrorRedLineView)
            vc.nameErrorLabel.text = Validation.nameValidator(text)
            return false
        }
        return true
    }
    
    //Pass validation
    func checkPass() -> Bool {
        guard let vc = signUpVC else { return false }
        guard let text = vc.inputPassTextField.text else { return false }
        if text.count >= 1 && Validation.passValidator(text) != "" {
            showError(vc.firstPassErrorLabel, vc.firstPassErrorLine)
            vc.firstPassErrorLabel.text = Validation.passValidator(text)
            return false
        }
        return true
    }
    
    //Pass confirmation validation
    func checkConfirmPass() -> Bool {
        guard let vc = signUpVC else { return false }
        guard let firstPass = vc.inputPassTextField.text else { return false }
        guard let secondPass = vc.inputConfirmPassTextField.text else { return false }
        if secondPass.count >= 1 && Validation.confirmPassValidator(firstPass, secondPass) != "" {
            showError(vc.passErrorLabel, vc.passErrorRedLineView)
            vc.passErrorLabel.text = Validation.confirmPassValidator(firstPass, secondPass)
            return false
        } else {
            self.passwordsAreEqual = true
            return true
            
        }
        
    }
    
    
    //MARK: - Show/hide errors
    func showError(_ label: UILabel, _ line: UIView) {
        label.textColor = .red
        line.backgroundColor = .red
    }
    
    func hideError(_ label: UILabel, _ line: UIView) {
        label.textColor = .clear
        line.backgroundColor = .lightGray
    }
    
    //MARK: - Show/hide required fields
    func showRequiredField(_ label: UILabel) {
        UIView.animate(withDuration: 0.25, animations: {
            label.textColor = .red
            label.text = ValidationErrors.required.rawValue
        })
    }
    
    func hideRequiredField(_ label: UILabel,_ text: String) {
        UIView.animate(withDuration: 0.25, animations: {
            label.textColor = .lightGray
            label.text = text
        })
    }
    
    //MARK: - Check through existing names at UserDefaults
    func checkSetForExisting(_ newName: String) -> Bool {
        guard let vc = signUpVC else { return true }
        if vc.userNameSet.contains(newName) {
            print("set contain \(newName)")
            return true
        } else {
            vc.userNameSet.insert(newName)
            print("new name inserted to set")
            return false
        }
    }
    
    //MARK: - Notificate user about existing an equal name at UserDefaults
    func showNotificationAboutExistingName() {
        guard let vc = signUpVC else { return }
        showError(vc.nameErrorLabel, vc.nameErrorRedLineView)
        vc.nameErrorLabel.text = ValidationErrors.existingName.rawValue
    }
    
}
