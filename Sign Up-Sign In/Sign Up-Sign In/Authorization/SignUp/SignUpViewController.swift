//
//  SignUpViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate: class {
    var isViewDismissed: Bool { get set }
//    func viewDismissed(_ isDismissed: Bool)
}

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
    weak var delegate: SignUpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setScreenButton(confirmRegistrationButton, "Confirm")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let delegate = delegate {
            delegate.isViewDismissed = true
        }
    }
    
    @IBAction func confirmRegistration(_ sender: Any) {
        
    }
    
 

}
