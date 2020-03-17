//
//  SignUpPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 17.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

class SignUpPresenter {
    
    weak var vc: SignUpViewController?
    let authPresenter = AuthPresenter()
    
    //MARK: - Check for empty text fields at SignUpViewController
    func checkForEmptyTextfield() -> Bool {
        guard let vc = vc else { return true }
        if vc.inputEmailTextField.text!.isEmpty {
            authPresenter.showRequiredField(vc.emailTitleLabel)
            return true
        }
        if vc.inputNameTextField.text!.isEmpty {
            authPresenter.showRequiredField(vc.nameTitleLabel)
            return true
        }
        if vc.inputPassTextField.text!.isEmpty {
            authPresenter.showRequiredField(vc.passTitleLabel)
            return true
        }
        if vc.inputConfirmPassTextField.text!.isEmpty {
            authPresenter.showRequiredField(vc.confirmPassTitleLabel)
            return true
        }
        return false
    }
    
    
}
