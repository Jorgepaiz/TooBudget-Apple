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
        // validate full name
        fullname = fullname.trimmingCharacters(in: .whitespacesAndNewlines)
        if fullname.isEmpty {
            errorFullname = "full_name_error_required"
        } else if !Validations.isValidFullName(fullname) {
            errorFullname = "full_name_error_name"
        } else {
            errorFullname = ""
        }
        
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
        if errorFullname.isEmpty && errorEmail.isEmpty && errorPassword.isEmpty {
            landingViewModel.createAccount(fullname: fullname, email: email, password: password)
        }
    }
}
