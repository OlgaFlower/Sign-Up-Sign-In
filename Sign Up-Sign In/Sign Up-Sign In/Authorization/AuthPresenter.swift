//
//  AuthPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class AuthPresenter {
    
    weak var authVC: AuthorizationViewController?
    
    func setScreenButton(_ button: UIButton, _ title: String) {
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
    }
    
    func hideShowAuthButtons(_ button1: UIButton, _ button2: UIButton, _ isDismissed: Bool) {
        if isDismissed == true {
            button1.isHidden = false
            button2.isHidden = false
        } else {
            button1.isHidden = true
            button2.isHidden = true
        }
    }
}
