//
//  Validations.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import Foundation

enum ValidationError: Error {
    case fullnameNotValid, fullnameIsRequired
    case emailNotValid, emailIsRequired
    case passwordPolicies, passwordIsRequired
}

final class Validations {
    // Combine all regex checks into a single method to reduce redundancy
    private func matches(_ string: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string)
    }
    
    // Generalized validation method to handle empty string validation and regex matching
    private func validate(_ value: String, with regex: String, emptyError: ValidationError, invalidError: ValidationError) throws -> Bool {
        guard !value.isEmpty else { throw emptyError }
        guard matches(value, regex: regex) else { throw invalidError }
        return true
    }
    
    func isValidFullname(_ fullname: String) throws -> Bool {
        let nameRegex = "^[A-Za-z]+(?:[\\'\\,\\.\\-][A-Za-z]+)*\\s[A-Za-z]+(?:[\\'\\,\\.\\-][A-Za-z]+)*$"
        return try validate(fullname, with: nameRegex, emptyError: .fullnameIsRequired, invalidError: .fullnameNotValid)
    }
    
    func isValidEmail(_ email: String) throws -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        return try validate(email, with: emailRegex, emptyError: .emailIsRequired, invalidError: .emailNotValid)
    }
    
    func isValidPassword(_ password: String) throws -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*(),.?\":{}|<>]{8,}$"
        return try validate(password, with: passwordRegex, emptyError: .passwordIsRequired, invalidError: .passwordPolicies)
    }
}
