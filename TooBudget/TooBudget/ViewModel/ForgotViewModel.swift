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
        // validate email
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if email.isEmpty {
            errorEmail = "email_error_required"
        } else if !Validations.isValidEmail(email) {
            errorEmail = "email_error_not_valid"
        } else {
            errorEmail = ""
        }
        
        // create account
        if errorEmail.isEmpty {
            landingViewModel.forgotPassword(email: email)
        }
    }
}
