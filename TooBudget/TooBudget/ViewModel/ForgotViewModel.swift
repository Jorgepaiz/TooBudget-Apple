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
}
