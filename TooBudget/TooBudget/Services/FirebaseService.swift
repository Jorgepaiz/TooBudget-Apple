//
//  FirebaseService.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/5/24.
//

import Foundation
import Firebase
import FirebaseAuth

final class FirebaseService: FirebaseServiceProtocol {
    func currentUser() -> User? {
        let user = Auth.auth().currentUser
        
        return user
    }
    
    func logIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else {
                completion(.failure(NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user."])))
                return
            }
            completion(.success(user))
        }
    }
    
    func createAccount(fullname: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else {
                completion(.failure(NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user after account creation."])))
                return
            }
            
            let changesRequest = user.createProfileChangeRequest()
            changesRequest.displayName = fullname
            changesRequest.commitChanges { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(user))
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Log out error, \(error.localizedDescription)")
        }
    }
}
