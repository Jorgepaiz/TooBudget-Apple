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
    
    func previousLogin() {
        if let _ = FirebaseService().currentUser() {
            coordinator.appCoordinator.navigate(.home)
        }
    }
    
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
        showActivityIndicator("message_sign_in") {
            let firebaseService = FirebaseService()
            
            firebaseService.logIn(email: email, password: password) { result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        self.closeAllSheets()
                        self.coordinator.appCoordinator.navigate(.home)
                        
                    case .failure(let error):
                        print("Error al loguear cuenta: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func createAccount(fullname: String, email: String, password: String) {
        showActivityIndicator("message_sign_up") {
            let firebaseService = FirebaseService()
            
            firebaseService.createAccount(fullname: fullname, email: email, password: password) { result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        self.closeAllSheets()
                        self.coordinator.appCoordinator.navigate(.home)
                        
                    case .failure(let error):
                        print("Error al crear cuenta: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func forgotPassword(email: String) {
        showActivityIndicator("message_forgot_password") {
            let firebaseService = FirebaseService()
            
            firebaseService.forgotPassword(email: email) { error in
                DispatchQueue.main.async {
                    if let error {
                        print("Error al enviar correo de cuenta: \(error.localizedDescription)")
                    } else {
                        self.closeAllSheets()
                    }
                }
            }
        }
    }
}
