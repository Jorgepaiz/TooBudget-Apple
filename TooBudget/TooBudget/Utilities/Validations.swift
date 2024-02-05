//
//  Validations.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import Foundation

final class Validations {
    public static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    public static func isValidFullName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z]+(?:[\\'\\,\\.\\-][A-Za-z]+)*\\s[A-Za-z]+(?:[\\'\\,\\.\\-][A-Za-z]+)*$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: name)
    }
    
    public static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*(),.?\":{}|<>]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}
