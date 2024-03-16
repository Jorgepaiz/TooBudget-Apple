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
    var isErrorToast = true
    
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
        isErrorToast = true
        withAnimation {
            showToastError.toggle()
        }
    }
    
    private func showError(_ error: FirebaseServiceError) {
        showError(title: "Authentication", message: error.localizedDescription)
    }
    
    private func successMessage() {
        closeAllSheets()
        toastErrorTitle = "Authentication"
        toastErrotMessage = "Message sent"
        isErrorToast = false
        withAnimation {
            showToastError.toggle()
        }
    }
    
    private func showActivityIndicator(_ message: String) {
        closeAllSheets()
        activityIndicatorMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.modalSheet.toggle()
        }
    }
    
    private func goToHome() {
        AnalyticsService.logInUser()
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
            CrashlyticsService.logError(error)
            showError(title: "Creating user", message: "Can't create a new user.")
        }
    }
    
    private func forgotPassword() {
        closeAllSheets()
    }
 
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
    
    func createUser(fullname: String, email: String, password: String) {
        showActivityIndicator("message_sign_up")
        let newUser = UserModel(fullname: fullname, email: email)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.authRepository.signUp(user: newUser, password: password)
                .sink(receiveCompletion: {
                    completion in
                    switch completion {
                    case .finished:
                        self.goToHome()
                    case .failure(let error):
                        AnalyticsService.logEvent(
                            "Error trying to Sign Up",
                            parameters: [AnalyticsParameterValue: error.localizedDescription]
                        )
                        self.showError(error)
                    }
                },
                      receiveValue: { user in
                    self.user = user
                })
                .store(in: &self.cancellables)
        }
    }
    
    func logIn(email: String,  password: String) {
        showActivityIndicator("message_sign_in")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.authRepository.signIn(email: email, password: password)
                .sink { completion in
                    switch completion {
                    case .finished:
                        self.goToHome()
                    case .failure(let error):
                        AnalyticsService.logEvent(
                            "Error trying to Sign In",
                            parameters: [AnalyticsParameterValue: error.localizedDescription]
                        )
                        self.showError(error)
                    }
                } receiveValue: { user in
                    self.user = user
                }
                .store(in: &self.cancellables)
        }
    }
    
    func forgotPassword(_ email: String) {
        showActivityIndicator("message_forgot_password")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.authRepository.forgotPassword(email)
                .sink { completion in
                    switch completion {
                    case .finished:
                        self.successMessage()
                    case .failure(let error):AnalyticsService.logEvent(
                        "Error trying to recover password",
                        parameters: [AnalyticsParameterValue: error.localizedDescription]
                    )
                        self.showError(error)
                    }
                } receiveValue: { _ in }
                .store(in: &self.cancellables)

        }
    }
}
