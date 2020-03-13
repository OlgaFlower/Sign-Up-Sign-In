//
//  AuthorizationViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController, SignUpViewControllerDelegate {
    
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    let presenter = AuthPresenter()
    var isViewDismissed: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.authVC = self
        
        presenter.setScreenButton(signUpButton, "SIGN UP")
        presenter.setScreenButton(signInButton, "SIGN IN")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(isViewDismissed)
        presenter.hideShowAuthButtons(signInButton, signUpButton, isViewDismissed)
        isViewDismissed = false
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        present(vc, animated: true, completion: nil)
        vc.delegate = self
        presenter.hideShowAuthButtons(signUpButton, signInButton, isViewDismissed)
        
    }
    
    
}
