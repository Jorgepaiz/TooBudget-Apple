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
}
