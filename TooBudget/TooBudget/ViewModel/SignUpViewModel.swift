//
//  SignUpViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import Observation

@Observable
final class SignUpViewModel {
    private let landingViewModel: LandingViewModel
    
    init(_ landingViewModel: LandingViewModel) {
        self.landingViewModel = landingViewModel
    }
    
    enum Fields {
        case fullname
        case email
        case password
    }
    
    var fullname = ""
    var email = ""
    var password = ""
    var errorFullname = ""
    var errorEmail = ""
    var errorPassword = ""
    
    func showSignInView() {
        landingViewModel.showSignInView()
    }
    
    func validateForm() {
        // Validator instance
        let validator = Validations()
        
        // Trim whitespaces and newlines
        fullname = fullname.trimmingCharacters(in: .whitespacesAndNewlines)
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Attempt validation
        do {
            try validate(fullname: fullname, with: validator)
            try validate(email: email, with: validator)
            try validate(password: password, with: validator)
            
            // Create account if all validations pass
            landingViewModel.createUser(fullname: fullname, email: email, password: password)
        } catch {
            // Handle specific errors
            CrashlyticsService.logError(error)
            handleError(error)
        }
    }
    
    // Specific validation functions
    private func validate(fullname: String, with validator: Validations) throws {
        guard try validator.isValidFullname(fullname) else { throw ValidationError.fullnameNotValid }
    }
    
    private func validate(email: String, with validator: Validations) throws {
        guard try validator.isValidEmail(email) else { throw ValidationError.emailNotValid }
    }
    
    private func validate(password: String, with validator: Validations) throws {
        guard try validator.isValidPassword(password) else { throw ValidationError.passwordPolicies }
    }
    
    // Centralized error handling
    private func handleError(_ error: Error) {
        // Clear previous error messages
        errorFullname.removeAll()
        errorEmail.removeAll()
        errorPassword.removeAll()
        
        if let authError = error as? ValidationError {
            switch authError {
            case .fullnameIsRequired:
                errorFullname = "full_name_error_required"
            case .fullnameNotValid:
                errorFullname = "full_name_error_name"
            case .emailIsRequired:
                errorEmail = "email_error_required"
            case .emailNotValid:
                errorEmail = "email_error_not_valid"
            case .passwordIsRequired:
                errorPassword = "password_error_required"
            case .passwordPolicies:
                errorPassword = "password_error_policies"
            }
        } else {
            // Log unknown errors
            print("Unknown Authentication error: \(error)")
        }
    }
    
}
