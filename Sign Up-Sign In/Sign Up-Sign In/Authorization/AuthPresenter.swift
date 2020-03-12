//
//  AuthPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class AuthPresenter {
    
    func setScreenButton(_ button: UIButton, _ title: String) {
//        let backColor = UIColor(red: 70, green: 72, blue: 57, alpha: 0.8)
//        button.backgroundColor = backColor
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
        
    }

}
