//
//  AuthRepository.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/19/24.
//

import Combine

final class AuthRepository {
    private let authService = AuthService.shared
    private let firestore = FirestoreService.shared
    
    func currentLogin() -> Bool {
        authService.currentLogin()
    }
    
    func signUp(user: UserModel, password: String) -> AnyPublisher<UserModel, FirebaseServiceError> {
        authService.signUp(user: user, password: password)
            .flatMap { [weak self] newUser -> AnyPublisher<UserModel, FirebaseServiceError> in
                guard let self = self else {
                    return Fail(error: FirebaseServiceError.errorSignUp)
                        .eraseToAnyPublisher()
                }
                
                return self.firestore.addUser(user: newUser)
                    .map { _ in newUser }
                    .mapError { _ in FirebaseServiceError.addingUserToFirestore }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<UserModel, FirebaseServiceError> {
        authService.signIn(email: email, password: password)
            .flatMap { [weak self] user -> AnyPublisher<UserModel, FirebaseServiceError> in
                guard let self = self else {
                    return Fail(error: FirebaseServiceError.errorSignIn)
                        .eraseToAnyPublisher()
                }
                
                return self.firestore.getUser(id: user.id)
                    .map { fetchUser in fetchUser }
                    .mapError { _ in FirebaseServiceError.errorRetrievingTheUser }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Bool, FirebaseServiceError> {
        authService.signOut()
    }
    
    func forgotPassword(_ email: String) -> AnyPublisher<Bool, FirebaseServiceError> {
        authService.forgotPassword(email)
    }
}
