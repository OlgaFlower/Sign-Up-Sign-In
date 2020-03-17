//
//  SignInPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 17.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

class SignInPresenter {
    
    weak var vc: SignInViewController?
    let authPresenter = AuthPresenter()
    
    //MARK: - Check for empty text fields at SignInViewController
    func checkForEmptyLoginTextfield() -> Bool {
        guard let vc = vc else { return true }
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
}
