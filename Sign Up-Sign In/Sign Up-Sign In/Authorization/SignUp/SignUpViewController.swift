//
//  SignUpViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var inputEmailTextField: UITextField!
    @IBOutlet weak var emailErrorRedLineView: UIView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var nameErrorRedLineView: UIView!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var passTitleLabel: UILabel!
    @IBOutlet weak var inputPassTextField: UITextField!
    @IBOutlet weak var confirmPassTitleLabel: UILabel!
    @IBOutlet weak var inputConfirmPassTextField: UITextField!
    @IBOutlet weak var passErrorRedLineView: UIView!
    @IBOutlet weak var passErrorLabel: UILabel!
    
    @IBOutlet weak var confirmRegistrationButton: UIButton!
    
    let presenter = AuthPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setScreenButton(confirmRegistrationButton, "CONFIRM")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func confirmRegistration(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogedInViewController") as! LogedInViewController
        show(vc, sender: self)
        
    }
    
 

}
