//
//  SignUpPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 17.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

class SignUpPresenter {
    
    weak var signUpVC: SignUpViewController?
    let authPresenter = AuthPresenter()
    
    func setLabels() {
        guard let vc = signUpVC else { return }
        vc.emailTitleLabel.text = "Email"
        vc.nameTitleLabel.text = "Name"
        vc.passTitleLabel.text = "Password"
        vc.confirmPassTitleLabel.text = "Confirm password"
    }
    
    //MARK: - Check for empty text fields at SignUpViewController
    func checkForEmptyTextfield() -> Bool {
        guard let vc = signUpVC else { return true }
        var textfieldIsEmpty = false
        
        if vc.inputEmailTextField.text!.isEmpty {
            textfieldIsEmpty = true
            authPresenter.showRequiredField(vc.emailTitleLabel)
        }
        if vc.inputNameTextField.text!.isEmpty {
            textfieldIsEmpty = true
            authPresenter.showRequiredField(vc.nameTitleLabel)
        }
        if vc.inputPassTextField.text!.isEmpty {
            textfieldIsEmpty = true
            authPresenter.showRequiredField(vc.passTitleLabel)
        }
        if vc.inputConfirmPassTextField.text!.isEmpty {
            textfieldIsEmpty = true
            authPresenter.showRequiredField(vc.confirmPassTitleLabel)
        }
        return textfieldIsEmpty
    }
    
    
}
