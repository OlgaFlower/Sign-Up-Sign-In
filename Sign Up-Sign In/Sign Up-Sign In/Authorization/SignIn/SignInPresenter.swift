//
//  SignInPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 17.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

class SignInPresenter {
    
    weak var signInVC: SignInViewController?
    let authPresenter = AuthPresenter()
    
    //MARK: - Check for empty text fields at SignInViewController
    func isLoginTextFieldsEmpty() -> Bool {
        guard let vc = signInVC else { return true }
        var textfieldIsEmpty = false
        
        if vc.inputNameTextField.text!.isEmpty == true {
            textfieldIsEmpty = true
            authPresenter.showRequiredField(vc.nameTitleLabel)
        }
        if vc.inputPassTextField.text!.isEmpty == true{
            textfieldIsEmpty = true
            authPresenter.showRequiredField(vc.passTitleLabel)
        }
        
        return textfieldIsEmpty
    }
    
    func setLabels() {
        guard let vc = signInVC else { return }
        vc.welcomeLabel.text = "Welcome back"
        vc.nameTitleLabel.text = "Name"
        vc.passTitleLabel.text = "Password"
        vc.createAccountLabel.text = "Don't have an account?"
    }
}
