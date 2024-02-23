//
//  FirebaseServiceErrorTests.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/22/24.
//

import XCTest
@testable import TooBudget

final class FirebaseServiceErrorTests: XCTestCase {

    func testAddingUserToFirestore() throws {
        XCTAssertThrowsError(try throwError(.addingUserToFirestore)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .addingUserToFirestore)
        }
    }
    
    func testErrorRetrievingTheUser() throws {
        XCTAssertThrowsError(try throwError(.errorRetrievingTheUser)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .errorRetrievingTheUser)
        }
    }
    
    func testErrorSignIn() throws {
        XCTAssertThrowsError(try throwError(.errorSignIn)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .errorSignIn)
        }
    }
    
    func testErrorSignOut() throws {
        XCTAssertThrowsError(try throwError(.errorSignOut)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .errorSignOut)
        }
    }
    
    func testErrorSignUp() throws {
        XCTAssertThrowsError(try throwError(.errorSignUp)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .errorSignUp)
        }
    }
    
    func testErrorUpdatingTheUser() throws {
        XCTAssertThrowsError(try throwError(.errorUpdatingTheUser)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .errorUpdatingTheUser)
        }
    }
    
    func testSignInInvalidCredential() throws {
        XCTAssertThrowsError(try throwError(.signInInvalidCredential)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .signInInvalidCredential)
        }
    }
    
    func testSignInUserDisabled() throws {
        XCTAssertThrowsError(try throwError(.signInUserDisabled)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .signInUserDisabled)
        }
    }
    
    func testSignUpEmailUsed() throws {
        XCTAssertThrowsError(try throwError(.signUpEmailUsed)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .signUpEmailUsed)
        }
    }
    
    func testFetchAllCollection() throws {
        XCTAssertThrowsError(try throwError(.fetchAllCollection)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .fetchAllCollection)
        }
    }
    
    func testErrorForgotPassword() throws {
        XCTAssertThrowsError(try throwError(.errorForgotPassword)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .errorForgotPassword)
        }
    }
    
    func testDecodeUser() throws {
        XCTAssertThrowsError(try throwError(.decodeUser)) { error in
            XCTAssertEqual(error as? FirebaseServiceError, .decodeUser)
        }
    }
    
    // MARK: - Helper Method
    
    private func throwError(_ error: FirebaseServiceError) throws {
        throw error
    }

}
