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
    func checkForEmptyLoginTextfield() -> Bool {
        guard let vc = signInVC else { return true }
        if vc.inputNameTextField.text!.isEmpty {
            authPresenter.showRequiredField(vc.nameTitleLabel)
            return true
        }
        if vc.inputPassTextField.text!.isEmpty {
            authPresenter.showRequiredField(vc.passTitleLabel)
            return true
        }
        return false
    }
    
    func setLabels() {
        guard let vc = signInVC else { return }
        vc.welcomeLabel.text = "Welcome back"
        vc.nameTitleLabel.text = "Name"
        vc.passTitleLabel.text = "Password"
        vc.createAccountLabel.text = "Don't have an account?"
    }
}
