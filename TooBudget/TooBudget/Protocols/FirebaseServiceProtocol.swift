//
//  FirebaseServiceProtocol.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/5/24.
//

import Foundation
import Firebase

protocol FirebaseServiceProtocol {
    func currentUser() -> User?
    func logIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func createAccount(fullname: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void)
    func signOut()
}
