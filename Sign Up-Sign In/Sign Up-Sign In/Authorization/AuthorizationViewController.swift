//
//  AuthorizationViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    let presenter = AuthPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setScreenButton(signUpButton, "SIGN UP")
        presenter.setScreenButton(signInButton, "SIGN IN")
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    
}
