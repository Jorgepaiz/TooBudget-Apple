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
}
