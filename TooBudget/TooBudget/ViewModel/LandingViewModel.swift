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
        showActivityIndicator("message_sign_up") {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("There was an error creating an account. Error detail: \(error.localizedDescription)")
                    return // Early exit on error
                }
                
                guard let user = result?.user else {
                    print("Failed to retrieve user after account creation.")
                    return // Early exit if user is unexpectedly nil
                }
                
                // Proceed to update the user profile
                self.updateUserProfile(for: user, withFullname: fullname)
            }
        }
    }
    
    private func updateUserProfile(for user: User, withFullname fullname: String) {
        let changesRequest = user.createProfileChangeRequest()
        changesRequest.displayName = fullname
        
        changesRequest.commitChanges { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                print("There was an error updating the account. Error detail: \(error.localizedDescription)")
                return // Early exit on error
            }
            
            print("Successfully created the user \(fullname) with the email \(String(describing: user.email))")
            self.closeAllSheets()
            self.coordinator.appCoordinator.navigate(.home)
        }
    }

    
    func forgotPassword(email: String) {
        showActivityIndicator("message_forgot_password") {}
    }
}
