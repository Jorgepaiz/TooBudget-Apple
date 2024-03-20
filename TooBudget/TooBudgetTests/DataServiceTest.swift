//
//  DataServiceTest.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/13/24.
//

import XCTest
@testable import TooBudget

final class DataServiceTest: XCTestCase {
    var dataService: DataService!
    var userRepository: UserRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Initialize DataService with an in-memory store to prevent performing tests on the actual database.
        dataService = DataService.shared
        dataService.inMemory = true
        userRepository = UserRepository()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try dataService.deleteModel()
        dataService = nil
        userRepository = nil
        
        try super.tearDownWithError()
    }
    
    // Ensure that DataService is a singleton by comparing instances.
    func testSingletonInstance() {
        XCTAssertEqual(dataService, DataService.shared, "DataService should be a singleton.")
    }
    
    // Check if the in-memory container is set up correctly.
    func testInMemoryContainerSetup() {
        XCTAssertNotNil(dataService.container, "The ModelContainer should be created.")
    }
    
    func testDeleteModel_clearsAllUsers() throws {
        // Given a user in the repository,
        var user: UserModel {
            UserModel(
                id: "test",
                fullname: "Test User",
                email: "test@email.com"
            )
        }
        try userRepository.createUser(user)
        
        // When deleteModel is called,
        try dataService.deleteModel()
        
        // Then there should be no users left in the repository.
        let users = try userRepository.fetchAllUsers()
        XCTAssertTrue(users.isEmpty, "All UserModel instances should be deleted from the persistent store.")
    }
}
