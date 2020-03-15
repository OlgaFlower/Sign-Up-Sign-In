//
//  Validation.swift
//  Sign Up-Sign In
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

enum RegistrationForm: String {
    case email = "Email"
    case name = "Name"
    case pass = "Password"
    case confirmPass = "Confirm password"
}

enum ValidationErrors: String {
    case noSpecial = "should contain at least one special symbol"
    case noNumbers = "should contain at least one number"
    case noUpperCase = "should contain at least one uppercase English character"
    case noLowerCase = "should contain at least one lowercase English character"
    case noDot = "should contain a dot"
    case noAt = "should contain @ symbol"
    case noCharsAfterDotInEmailDomain = "should contain at least 2 characters after dot"
    case shortString = "should contain at least 6 and max 20 symbols"
    case shortEmail = "should contain at least 7 and max 25 symbols"
    case moreThanOneAtSymbol = "shouldn't contain more than one @ symbol"
    case incorrectEmail = "Incorrect email"
    case incorrectName = "should contain at least one upper/lowercase English character"
    case passLength = "length is not equal"
    case passNotEqual = "arn't equal"
    case required = "Required field"
    case existingName = "This name is already registered"
}

class Validation {
    
    //MARK: - Validation properties
    static let special = CharacterSet(charactersIn: "!@#$%^&*()-+")
    static let numbers = CharacterSet(charactersIn: "0123456789")
    static let upper = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    static let lower = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
    static let symbolAt = CharacterSet(charactersIn: "@")
    static let dot = CharacterSet(charactersIn: ".")
    static let restrictedSymbols = #",/:;<=>?[\]“‘“"_`{'|}~ "#
    
    //MARK: - Email validator
    static func emailValidator(_ email: String) -> String {
        let word = "Email "
        if email.count < 7 {
            return word + ValidationErrors.shortEmail.rawValue
            
        }
        if email.rangeOfCharacter(from: symbolAt) == nil {
            return word + ValidationErrors.noAt.rawValue
        }
        if email.rangeOfCharacter(from: dot) == nil {
            return word + ValidationErrors.noDot.rawValue
        }
        if email.indexOf("@")! > email.lastIndex(of: ".")! {
            return word + ValidationErrors.moreThanOneAtSymbol.rawValue
        }
        if checkAmountOfCharsAfterPoint(email) == false {
            return ValidationErrors.incorrectEmail.rawValue
        }
        return ""
    }
    
    //MARK: - Name validator
    static func nameValidator(_ name: String) -> String {
        let word = "Name "
        var allowed = CharacterSet()
        allowed.formUnion(.lowercaseLetters)
        allowed.formUnion(.uppercaseLetters)
        
        if name.count < 6 {
            return word + ValidationErrors.shortString.rawValue
        }
        if name.rangeOfCharacter(from: allowed) == nil {
            return word + ValidationErrors.incorrectName.rawValue
        }
        if name.rangeOfCharacter(from: numbers) == nil {
            return word + ValidationErrors.noNumbers.rawValue
        }
        return ""
    }
    
    //MARK: - Pass validator
    static func passValidator(_ pass: String) -> String {
        let word = "Password "
        if pass.count < 6 {
            return word + ValidationErrors.shortString.rawValue
        }
        if pass.rangeOfCharacter(from: lower) == nil {
            return word + ValidationErrors.noLowerCase.rawValue
        }
        if pass.rangeOfCharacter(from: upper) == nil {
            return word + ValidationErrors.noUpperCase.rawValue
        }
        if pass.rangeOfCharacter(from: numbers) == nil {
            return word + ValidationErrors.noNumbers.rawValue
        }
        if pass.rangeOfCharacter(from: special) == nil {
            return word + ValidationErrors.noSpecial.rawValue
        }
        return ""
    }
    
    //MARK: - Confirm pass validator
    static func confirmPassValidator(_ firstPass: String, _ secondPass: String) -> String {
        let word = "Passwords "
        if (firstPass.count < secondPass.count) || (firstPass.count > secondPass.count) {
            return word + ValidationErrors.passLength.rawValue
        }
        if firstPass != secondPass {
            return word + ValidationErrors.passNotEqual.rawValue
        }
        return ""
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
