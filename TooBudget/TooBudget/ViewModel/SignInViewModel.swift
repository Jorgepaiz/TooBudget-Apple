//
//  SignInViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/3/24.
//

import Observation

@Observable
final class SignInViewModel {
    private let landingViewModel: LandingViewModel
    
    init(_ landingViewModel: LandingViewModel) {
        self.landingViewModel = landingViewModel
    }
    
    enum Fields {
        case email
        case password
    }
    
    var email = ""
    var password = ""
    var rememberMe = true
    var errorEmail = ""
    var errorPassword = ""
    
    func showSignUpView() {
        landingViewModel.showSignUpView()
    }
    
    func showForgotView() {
        landingViewModel.showForgotView()
    }
    
    func validateForm() {
        // Validator instance
        let validator = Validations()
        
        // Trim whitespaces and newlines
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Attempt validation
        do {
            try validate(email: email, with: validator)
            try validate(password: password, with: validator)
            
            // Create account if all validations pass
            landingViewModel.logIn(email: email, password: password)
        } catch {
            // Handle specific errors
            handleError(error)
        }
    }
    
    // Specific validation functions
    private func validate(email: String, with validator: Validations) throws {
        guard try validator.isValidEmail(email) else { throw ValidationError.emailNotValid }
    }
    
    private func validate(password: String, with validator: Validations) throws {
        guard try validator.isValidPassword(password) else { throw ValidationError.passwordPolicies }
    }
    
    // Centralized error handling
    private func handleError(_ error: Error) {
        // Clear previous error messages
        errorEmail.removeAll()
        errorPassword.removeAll()
        
        if let authError = error as? ValidationError {
            switch authError {
            case .emailIsRequired:
                errorEmail = "email_error_required"
            case .emailNotValid:
                errorEmail = "email_error_not_valid"
            case .passwordIsRequired:
                errorPassword = "password_error_required"
            case .passwordPolicies:
                errorPassword = "password_error_policies"
            default:
                print("Unknown Authentication error: \(error)")
            }
        }
    }
}
