//
//  Validation.swift
//  Sign Up-Sign In
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation


    
//    case special = "!@#$%^&*()-+"
//    case numbers = "0123456789"
//    case upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//    case lowerCase = "abcdefghijklmnopqrstuvwxyz"
//    case dotSymbol = "."
//    case atSymbol = "@"


enum ValidationErrors: String {
    case noSpecial = "should contain at least one special symbol"
    case noNumbers = "should contain at least one number"
    case noUpperCase = "should contain at least one uppercase English character"
    case noLowerCase = "should contain at least one lowercase English character"
    case noDot = "should contain a dot"
    case noAt = "should contain @ symbol"
    case noCharsAfterDotInEmailDomain = "should contain at least 2 characters after dot"
    case shortInput = "the length should be 6 - 20 symbols"
    case required = "Required field"
}

class Validation {
    
    static let special = CharacterSet(charactersIn: "!@#$%^&*()-+")
    static let number = CharacterSet(charactersIn: "0123456789")
    static let upper = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    static let lower = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
    
    
    static func passValidator(_ pass: String) -> String? {

        if pass.rangeOfCharacter(from: lower) == nil {
            return ValidationErrors.noLowerCase.rawValue
        }
        if pass.rangeOfCharacter(from: upper) == nil {
            return ValidationErrors.noUpperCase.rawValue
        }
        if pass.rangeOfCharacter(from: number) == nil {
            return ValidationErrors.noNumbers.rawValue
        }
        if pass.rangeOfCharacter(from: special) == nil {
            return ValidationErrors.noSpecial.rawValue
        }
        if pass.count < 6 || pass.count > 20 {
            return ValidationErrors.shortInput.rawValue
        }
        
        return nil
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
