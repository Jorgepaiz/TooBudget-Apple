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
import SwiftData
import Combine

@Observable
final class LandingViewModel {
    private let coordinator: LandingCoordinator
    private let authRepository = AuthRepository()
    private var cancellables = Set<AnyCancellable>()
    private var user: UserModel?
    
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
    
    private func closeAllSheets() {
        signInSheet = false
        signUpSheet = false
        forgotSheet = false
        modalSheet = false
        showToastError = false
    }
    
    private func showError(title: String, message: String) {
        closeAllSheets()
        toastErrorTitle = title
        toastErrotMessage = message
        withAnimation {
            showToastError.toggle()
        }
    }
    
    private func showError(_ error: FirebaseServiceError) {
        showError(title: "Authentication", message: error.localizedDescription)
    }
    
    private func showActivityIndicator(_ message: String) {
        closeAllSheets()
        activityIndicatorMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.modalSheet.toggle()
        }
    }
    
    
    
//    private func proccessLoginOrCreateResponse(_ result: Result<User, Error>, isLogin: Bool = true) {
//        let titleError = isLogin ? "sign_in_error_title" : "sign_up_error_title"
//        
//        switch result {
//        case .success(let user):
//            if let fullname = user.displayName,
//               let email = user.email {
//                let newUser = UserModel(id: user.uid, fullname: fullname, email: email)
//                if initializingDataModel(newUser, isLogin: isLogin) {
//                    coordinator.appCoordinator.navigate(to: .home)
//                }
//            } else {
//                showError(title: titleError, message: "Can't fetch user information.")
//            }
//        case .failure(let error):
//            showError(title: titleError, message: error.localizedDescription)
//        }
//    }
    
//    private func initializingDataModel(_ user: UserModel, isLogin: Bool) -> Bool {
//        if isLogin {
//            // TODO: flow for recover data
//            return true
//        } else {
//            firebaseService.signOut()
//            do {
//                try DataService.shared.deleteModel()
//                try UserRepository().createUser(user)
//                return true
//            } catch {
//                showError(title: "Creating user", message: "Can't create a new user.")
//                return false
//            }
//        }
//    }
    
    func previousLogin() {
        if authRepository.currentLogin() {
            coordinator.appCoordinator.navigate(to: .home)
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
    
//    func logIn(email: String, password: String) {
//        showActivityIndicator("message_sign_in") {
//            let firebaseService = FirebaseService()
//            
//            firebaseService.logIn(email: email, password: password) { result in
//                DispatchQueue.main.async {
//                    self.closeAllSheets()
//                    self.proccessLoginOrCreateResponse(result)
//                }
//            }
//        }
//    }
    
//    func createAccount(fullname: String, email: String, password: String) {
//        showActivityIndicator("message_sign_up") {
//            let firebaseService = FirebaseService()
//            
//            firebaseService.createAccount(fullname: fullname, email: email, password: password) { result in
//                DispatchQueue.main.async {
//                    self.closeAllSheets()
//                    self.proccessLoginOrCreateResponse(result, isLogin: false)
//                }
//            }
//        }
//    }
    
//    func forgotPassword(email: String) {
//        showActivityIndicator("message_forgot_password") {
//            let firebaseService = FirebaseService()
//            
//            firebaseService.forgotPassword(email: email) { error in
//                DispatchQueue.main.async {
//                    if let error {
//                        print("Error al enviar correo de cuenta: \(error.localizedDescription)")
//                    } else {
//                        self.closeAllSheets()
//                    }
//                }
//            }
//        }
//    }
    
    private func createUser() {
        closeAllSheets()
        
        guard let user = self.user else {
            showError(title: "Creating user", message: "Don't exist user")
            return
        }
        
        do {
            try DataService.shared.deleteModel()
            try UserRepository().createUser(user)
            coordinator.appCoordinator.navigate(to: .home)
        } catch {
            showError(title: "Creating user", message: "Can't create a new user.")
        }
    }
    
    func createUser(fullname: String, email: String, password: String) {
        showActivityIndicator("message_sign_up")
        let newUser = UserModel(fullname: fullname, email: email)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.authRepository.signUp(user: newUser, password: password)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.createUser()
                    case .failure(let error):
                        self.showError(error)
                    }
                }, receiveValue: { user in
                    self.user = user
                })
                .store(in: &self.cancellables)
        }
    }
}
