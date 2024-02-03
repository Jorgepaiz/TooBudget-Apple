//
//  LandingViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Foundation
import Observation

@Observable
final class LandingViewModel: ViewModelProtocol {
    let coordinator: CoordinatorProtocol
    
    init(_ coordinator: LandingCoordinator) {
        self.coordinator = coordinator
    }
    
    var sheetOfSignInView = false
    var sheetOfSignUpView = false
    var sheetOfForgotView = false
    var showActivityIndicator = false
    
    private func closeAllSheets() {
        sheetOfSignInView = false
        sheetOfSignUpView = false
        sheetOfForgotView = false
        showActivityIndicator = false
    }
    
    func showSignInView() {
        closeAllSheets()
        sheetOfSignInView.toggle()
    }
    
    func showSignUpView() {
        closeAllSheets()
        sheetOfSignUpView.toggle()
    }
    
    func showForgotView() {
        closeAllSheets()
        sheetOfForgotView.toggle()
    }
}
