//
//  ForgotViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import Observation

@Observable
final class ForgotViewModel {
    private let landingViewModel: LandingViewModel
    
    init(_ landingViewModel: LandingViewModel) {
        self.landingViewModel = landingViewModel
    }
    
    var email = ""
    var errorEmail = ""
    
    func showSignInView() {
        landingViewModel.showSignInView()
    }
    
    func validateForm() {
        // Validator instance
        let validator = Validations()
        
        // Trim whitespaces and newlines
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Attempt validation
        do {
            try validate(email: email, with: validator)
            
            // Create account if all validations pass
            landingViewModel.forgotPassword(email: email)
        } catch {
            // Handle specific errors
            handleError(error)
        }
    }
    
    // Specific validation functions
    private func validate(email: String, with validator: Validations) throws {
        guard try validator.isValidEmail(email) else { throw ValidationError.emailNotValid }
    }
    
    // Centralized error handling
    private func handleError(_ error: Error) {
        // Clear previous error messages
        errorEmail.removeAll()
        
        if let authError = error as? ValidationError {
            switch authError {
            case .emailIsRequired:
                errorEmail = "email_error_required"
            case .emailNotValid:
                errorEmail = "email_error_not_valid"
            default:
                print("Unknown Authentication error: \(error)")
            }
        }
    }
        
}
