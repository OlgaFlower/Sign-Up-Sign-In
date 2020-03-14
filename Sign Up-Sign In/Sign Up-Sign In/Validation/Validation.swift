//
//  Validation.swift
//  Sign Up-Sign In
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

class Validation {
    
    
    
    static func passValidator(_ pass: String) -> Bool {
        
        let special = CharacterSet(charactersIn: "!@#$%^&*()-+")
        let number = CharacterSet(charactersIn: "0123456789")
        let upper = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let lower = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
        
        if pass.rangeOfCharacter(from: lower) == nil {
            return false
        }
        if pass.rangeOfCharacter(from: upper) == nil {
            return false
        }
        if pass.rangeOfCharacter(from: number) == nil {
            return false
        }
        if pass.rangeOfCharacter(from: special) == nil {
            return false
        }
        return true
    }
    
    static func emailValidator(_ email: String) -> Bool {
        let symbolAt = CharacterSet(charactersIn: "@")
        let point = CharacterSet(charactersIn: ".")
        
        if email.rangeOfCharacter(from: symbolAt) == nil { return false }
        
        if email.rangeOfCharacter(from: point) == nil { return false }
        
        if email.indexOf("@")! > email.lastIndex(of: ".")! { return false }
        
        if checkAmountOfCharsAfterPoint(email) == false { return false }
        
        return true
    }
    
    static func nameValidator(_ name: String) -> Bool {
        if name.count < 6 && name.count > 20 {
            return false
        }
        return true 
    }
    
    static func checkAmountOfCharsAfterPoint(_ email: String) -> Bool {
        guard let lastSymbol = email.lastIndex(of: ".") else { return false }
        let startIndex = email.index(lastSymbol, offsetBy: 1)
        let substring = email[startIndex ..< email.endIndex]
        if substring.count < 2 { return false }
        return true
    }
}

extension String {
    //MARK: - Return char's indexes
    func indexOf(_ input: String, options: String.CompareOptions = .literal) -> String.Index? {
        return self.range(of: input, options: options)?.lowerBound
    }
    
    func lastIndexOf(_ input: String) -> String.Index? {
        return indexOf(input, options: .backwards)
    }
}
