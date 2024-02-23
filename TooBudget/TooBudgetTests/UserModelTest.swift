//
//  UserModelTest.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/13/24.
//

import XCTest
@testable import TooBudget

final class UserModelTest: XCTestCase {

    func testUserModelInitializerFull() {
        // Given
        let id = UUID().uuidString
        let name = "TestName"
        let signUpType = SignUpType.email
        let secondName = "TestSecondName"
        let surname = "TestSurname"
        let secondSurname = "TestSecondSurname"
        let email = "test@example.com"
        let notes = "This is a test note."
        let createdAt = Date()
        let updatedAt = Date()
//        let budget1 = BudgetModel(name: "\(name) 1", owner: "owner1")
//        let budget2 = BudgetModel(name: "\(name) 1", owner: "owner2")
        
        // When
        let userModel = UserModel(
            id: id,
            name: name,
            signUpType: signUpType,
            secondName: secondName,
            surname: surname,
            secondSurname: secondSurname,
            email: email,
//            budgets: [budget1, budget2],
//            currentBudget: budget2,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // Then
        XCTAssertEqual(userModel.id, id)
        XCTAssertEqual(userModel.name, name)
        XCTAssertEqual(userModel.signUpType, signUpType)
        XCTAssertEqual(userModel.secondName, secondName)
        XCTAssertEqual(userModel.surname, surname)
        XCTAssertEqual(userModel.secondSurname, secondSurname)
        XCTAssertEqual(userModel.email, email)
        XCTAssertEqual(userModel.notes, notes)
        XCTAssertEqual(userModel.createdAt, createdAt)
        XCTAssertEqual(userModel.updatedAt, updatedAt)
        XCTAssertTrue(userModel.budgets.isEmpty)
        XCTAssertNil(userModel.currentBudget)
    }
    
    func testUserModelConvenienceInitializer() {
        // Given
        let id = UUID().uuidString
        let fullname = "John Doe"
        let email = "john.doe@example.com"
        
        // When
        let userModel = UserModel(id: id, fullname: fullname, email: email)
        
        // Then
        XCTAssertEqual(userModel.id, id)
        XCTAssertEqual(userModel.name, "John")
        XCTAssertEqual(userModel.signUpType, SignUpType.email)
        XCTAssertTrue(userModel.secondName.isEmpty)
        XCTAssertEqual(userModel.surname, "Doe")
        XCTAssertTrue(userModel.secondSurname.isEmpty)
        XCTAssertEqual(userModel.email, email)
        XCTAssertTrue(userModel.budgets.isEmpty)
        XCTAssertNil(userModel.currentBudget)
        XCTAssertTrue(userModel.notes.isEmpty)
        XCTAssertNotNil(userModel.createdAt)
        XCTAssertNotNil(userModel.createdAt)
    }
    
    func t2estEncodingAndDecoding() {
        // Given
        let userModel = UserModel(
            id: "user123",
            name: "John",
            signUpType: SignUpType.email,
            secondName: "Quincy",
            surname: "Doe",
            secondSurname: "Public",
            email: "john.doe@example.com",
            notes: "Some important notes",
            createdAt: Date(timeIntervalSince1970: 10000),
            updatedAt: Date(timeIntervalSince1970: 20000)
        )
//        let budget1 = BudgetModel(
//            name: "Personal Finances",
//            owner: "John Doe"
//        )
//        let budget2 = BudgetModel(
//            name: "Business Expenses",
//            owner: "John Doe"
//        )
//        userModel.budgets = [budget1, budget2]
//        userModel.currentBudget = budget2
        
        // When
        do {
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            let data = try encoder.encode(userModel)
            let decodedUserModel = try decoder.decode(UserModel.self, from: data)
            
            // Then
            XCTAssertEqual(decodedUserModel.id, userModel.id)
            XCTAssertEqual(decodedUserModel.name, userModel.name)
            XCTAssertEqual(decodedUserModel.signUpType, userModel.signUpType)
            XCTAssertEqual(decodedUserModel.secondName, userModel.secondName)
            XCTAssertEqual(decodedUserModel.surname, userModel.surname)
            XCTAssertEqual(decodedUserModel.secondSurname, userModel.secondSurname)
            XCTAssertEqual(decodedUserModel.email, userModel.email)
            XCTAssertEqual(decodedUserModel.notes, userModel.notes)
            XCTAssertEqual(decodedUserModel.createdAt.timeIntervalSince1970, userModel.createdAt.timeIntervalSince1970)
            XCTAssertEqual(decodedUserModel.updatedAt.timeIntervalSince1970, userModel.updatedAt.timeIntervalSince1970)
            XCTAssertEqual(decodedUserModel.budgets.count, userModel.budgets.count)
            XCTAssertNotNil(decodedUserModel.currentBudget)
        } catch {
            XCTFail("Error encoding or decoding BudgetModel: \(error)")
        }
    }

    func testUserModelToDictionary() {
        let userModel = UserModel(id: UUID().uuidString, fullname: "John Doe", email: "john.doe@example.com")
        
        if let dictionary = userModel.toDictionary() {
            XCTAssertEqual(dictionary["_name"] as? String, userModel.name)
            XCTAssertEqual(dictionary["_surname"] as? String, userModel.surname)
            XCTAssertEqual(dictionary["_email"] as? String, userModel.email)
            XCTAssertNotNil(dictionary["_id"])
            XCTAssertNotNil(dictionary["_createdAt"])
            XCTAssertNotNil(dictionary["_updatedAt"])
        } else {
            XCTFail("Failed to convert UserModel to dictionary")
        }
    }
}
