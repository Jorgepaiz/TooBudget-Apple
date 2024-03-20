//
//  DataServiceErrorTests.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/22/24.
//

import XCTest
@testable import TooBudget

final class DataServiceErrorTests: XCTestCase {

    // MARK: - General Error
    
    func testDeleteModelErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.deleteModel)) { error in
            XCTAssertEqual(error as? DataServiceError, .deleteModel)
        }
    }
    
    // MARK: - User Errors
    
    func testCreateUserErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.createUser)) { error in
            XCTAssertEqual(error as? DataServiceError, .createUser)
        }
    }
    
    func testReadUserErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.readUser)) { error in
            XCTAssertEqual(error as? DataServiceError, .readUser)
        }
    }
    
    func testUpdateUserErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.updateUser)) { error in
            XCTAssertEqual(error as? DataServiceError, .updateUser)
        }
    }
    
    func testDeleteUserErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.deleteUser)) { error in
            XCTAssertEqual(error as? DataServiceError, .deleteUser)
        }
    }
    
    func testUserNotFoundErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.userNotFound)) { error in
            XCTAssertEqual(error as? DataServiceError, .userNotFound)
        }
    }
    
    // MARK: - Budget Errors
    
    func testCreateBudgetErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.createBudget)) { error in
            XCTAssertEqual(error as? DataServiceError, .createBudget)
        }
    }
    
    func testReadBudgetErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.readBudget)) { error in
            XCTAssertEqual(error as? DataServiceError, .readBudget)
        }
    }
    
    func testUpdateBudgetErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.updateBudget)) { error in
            XCTAssertEqual(error as? DataServiceError, .updateBudget)
        }
    }
    
    func testDeleteBudgetErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.deleteBudget)) { error in
            XCTAssertEqual(error as? DataServiceError, .deleteBudget)
        }
    }
    
    func testBudgetNotFoundErrorThrowing() throws {
        XCTAssertThrowsError(try throwError(.budgetNotFound)) { error in
            XCTAssertEqual(error as? DataServiceError, .budgetNotFound)
        }
    }
    
    // MARK: - Helper Methods
    
    private func throwError(_ error: DataServiceError) throws {
        throw error
    }

}
