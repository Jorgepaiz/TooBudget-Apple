//
//  FirebaseServiceError.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/19/24.
//

import Foundation

enum FirebaseServiceError: Error {
    case addingUserToFirestore
    case errorRetrievingTheUser
    case errorSignIn
    case errorSignOut
    case errorSignUp
    case errorUpdatingTheUser
    case signInInvalidCredential
    case signInUserDisabled
    case signUpEmailUsed
    case fetchAllCollection
    case errorForgotPassword
    case decodeUser
}
