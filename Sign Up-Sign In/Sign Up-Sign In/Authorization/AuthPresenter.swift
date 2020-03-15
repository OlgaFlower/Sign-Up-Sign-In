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
    let restrictedSymbols = #",/:;<=>?[\]“‘“"_`{'|}~ "#
    
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
    
    //MARK: - Validation
    func checkForValidPass(_ password: UITextField, _ errorLabel: UILabel, _ errorLine: UIView) -> Bool {
        guard let pass = password.text else {
            showError(errorLabel, errorLine)
            errorLabel.text = ValidationErrors.required.rawValue
            return false }
        if Validation.passValidator(pass) != nil {
            showError(errorLabel, errorLine)
            errorLabel.text = Validation.passValidator(pass)
            return false
        }
        hideError(errorLabel, errorLine)
        return true
    }
    
    func showError(_ label: UILabel, _ line: UIView) {
        label.textColor = .red
        line.backgroundColor = .red
    }
    
    func hideError(_ label: UILabel, _ line: UIView) {
        label.textColor = .clear
        line.backgroundColor = .lightGray
    }
    
}
