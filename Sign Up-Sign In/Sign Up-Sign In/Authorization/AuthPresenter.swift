//
//  AuthPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class AuthPresenter {
    
    weak var signInVC: SignInViewController?
    
    func setScreenButton(_ button: UIButton, _ title: String) {
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
        
    }
    
    //transparent navbar
    func setNavBar() {
        signInVC?.navigationController?.setNavigationBarHidden(true, animated: true)
        signInVC?.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        signInVC?.navigationController!.navigationBar.isTranslucent = true
        
    }
}
