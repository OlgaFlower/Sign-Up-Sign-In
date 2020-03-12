//
//  AuthPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class AuthPresenter {
    
    func setStartScreenButtons(_ button: UIButton, _ buttonTitle: String) {
        button.setTitle(buttonTitle, for: .normal)
        button.layer.cornerRadius = 23
    }
    
}
