//
//  SignInViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var inputEmailTextField: UITextField!
    @IBOutlet weak var errorEmailRedLineView: UIView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passTitleLabel: UILabel!
    @IBOutlet weak var inputPassTextField: UITextField!
    @IBOutlet weak var errorPassRedLineView: UIView!
    @IBOutlet weak var passErrorLabel: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    
    let presenter = AuthPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setScreenButton(logInButton, "Confirm")
    
    }
    

    @IBAction func confirmLogin(_ sender: Any) {
        
    }
    

}
