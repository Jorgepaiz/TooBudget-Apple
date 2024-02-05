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
        // validate email
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if email.isEmpty {
            errorEmail = "email_error_required"
        } else if !Validations.isValidEmail(email) {
            errorEmail = "email_error_not_valid"
        } else {
            errorEmail = ""
        }
        
        // validate password
        if password.isEmpty {
            errorPassword = "password_error_required"
        } else if !Validations.isValidPassword(password) {
            errorPassword = "password_error_policies"
        } else {
            errorPassword = ""
        }
        
        // create account
        if errorEmail.isEmpty && errorPassword.isEmpty {
            landingViewModel.logIn(email: email, password: password)
        }
    }
}
