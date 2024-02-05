//
//  LandingViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Foundation
import Observation
import FirebaseAuth

@Observable
final class LandingViewModel: ViewModelProtocol {
    let coordinator: CoordinatorProtocol
    
    init(_ coordinator: LandingCoordinator) {
        self.coordinator = coordinator
    }
    
    var signInSheet = false
    var signUpSheet = false
    var forgotSheet = false
    var modalSheet = false
    var activityIndicatorMessage = ""
    
    private func closeAllSheets() {
        signInSheet = false
        signUpSheet = false
        forgotSheet = false
        modalSheet = false
    }
    
    private func showActivityIndicator(_ message: String, action: @escaping () -> Void) {
        closeAllSheets()
        activityIndicatorMessage = NSLocalizedString(message, comment: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.modalSheet.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                action()
            }
        }
    }
    
    func showSignInView() {
        closeAllSheets()
        signInSheet.toggle()
    }
    
    func showSignUpView() {
        closeAllSheets()
        signUpSheet.toggle()
    }
    
    func showForgotView() {
        closeAllSheets()
        forgotSheet.toggle()
    }
    
    func logIn(email: String, password: String) {
        showActivityIndicator("message_sign_in") {}
    }
    
    func createAccount(fullname: String, email: String, password: String) {
        showActivityIndicator("message_sign_up") {}
    }
    
    func forgotPassword(email: String) {
        showActivityIndicator("message_forgot_password") {}
    }
}
