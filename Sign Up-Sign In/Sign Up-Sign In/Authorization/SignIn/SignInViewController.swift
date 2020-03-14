//
//  SignInViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!

    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var inputEmailTextField: UITextField!
    @IBOutlet weak var errorEmailRedLineView: UIView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passTitleLabel: UILabel!
    @IBOutlet weak var inputPassTextField: UITextField!
    @IBOutlet weak var errorPassRedLineView: UIView!
    @IBOutlet weak var passErrorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    let presenter = AuthPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setScreenButton(loginButton, "CONFIRM")
        welcomeLabel.text = "Welcome back"
        createAccountLabel.text = "Don't have an account?"
        signUpButton.setTitle("Sign Up", for: .normal)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    

    @IBAction func confirmLogin(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogedInViewController") as! LogedInViewController
        show(vc, sender: self)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        show(vc, sender: self)
//        present(vc, animated: true, completion: nil)
    }
    
}
