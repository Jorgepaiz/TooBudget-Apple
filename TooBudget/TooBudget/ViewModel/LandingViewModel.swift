//
//  LandingViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Firebase
import FirebaseAuth
import Observation
import SwiftUI

@Observable
final class LandingViewModel {
    let coordinator: LandingCoordinator
    
    init(_ coordinator: LandingCoordinator) {
        self.coordinator = coordinator
    }
    
    var signInSheet = false
    var signUpSheet = false
    var forgotSheet = false
    var modalSheet = false
    var activityIndicatorMessage = ""
    var showToastError = false
    var toastErrorTitle = ""
    var toastErrotMessage = ""
    
    func previousLogin() {
        if let _ = FirebaseService().currentUser() {
            coordinator.appCoordinator.navigate(to: .home)
        }
    }
    
    private func closeAllSheets() {
        signInSheet = false
        signUpSheet = false
        forgotSheet = false
        modalSheet = false
        showToastError = false
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
    
    private func proccessLoginOrCreateResponse(_ result: Result<User, Error>, isLogin: Bool = true) {
        switch result {
        case .success(let user):
            if let fullname = user.displayName,
               let email = user.email {
                let newUser = UserModel(id: user.uid, fullname: fullname, email: email)
                Task {
                    await initializingDataModel(newUser, isLogin: isLogin)
                }
                self.coordinator.appCoordinator.navigate(to: .home)
            } else {
                // TODO: show a ToastView with the error detail
            }
        case .failure(let error):
            print("Login or create account error. Description: \(error.localizedDescription)")
            toastErrorTitle = isLogin ? "sign_in_error_title" : "sign_up_error_title"
            toastErrotMessage = error.localizedDescription
            withAnimation {
                showToastError.toggle()
            }
        }
    }
    
    private func initializingDataModel(_ user: UserModel, isLogin: Bool) async {
        if isLogin {
            // TODO: flow for recover data
        } else {
            // start with new data
            await deleteAllUsers()
            await createUser(user)
        }
    }
    
    private func fetchAllUser() async {
        let userRepository = UserRepository()
        do {
            let users = try await userRepository.fetchAll()
            print("All users: \(users)")
        } catch {
            print("Error fetching all users, detail: \(error.localizedDescription)")
        }
    }
    
    private func createUser(_ user: UserModel) async {
        let userRepository = UserRepository()
        do {
            try await userRepository.createUser(user)
        } catch {
            print("Error creating user, detail: \(error.localizedDescription)")
        }
    }
    
    private func deleteAllUsers() async {
        let userRepository = UserRepository()
        do {
            try await userRepository.deleteAll()
        } catch {
            print("Error deleting all users, detail: \(error.localizedDescription)")
        }
    }
    
    func testDataBase() async {
        await fetchAllUser()
        let user = UserModel(id: "user" + String(Int.random(in: 0...100)), fullname: "jorge paiz", email: "jorge@paiz.com")
        await createUser(user)
        await fetchAllUser()
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
                    self.closeAllSheets()
                    self.proccessLoginOrCreateResponse(result)
                }
            }
        }
    }
    
    func createAccount(fullname: String, email: String, password: String) {
        showActivityIndicator("message_sign_up") {
            let firebaseService = FirebaseService()
            
            firebaseService.createAccount(fullname: fullname, email: email, password: password) { result in
                DispatchQueue.main.async {
                    self.closeAllSheets()
                    self.proccessLoginOrCreateResponse(result, isLogin: false)
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
