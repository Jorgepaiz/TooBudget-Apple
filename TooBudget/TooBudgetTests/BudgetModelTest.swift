//
//  BudgetModelTest.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/13/24.
//

import XCTest
@testable import TooBudget

final class BudgetModelTest: XCTestCase {

    func testBudgetModelInitializer() {
        // Given
        let id = UUID()
        let name = "Monthly Expenses"
        let type = BudgetType.personal
        let owner = "OwnerID"
        let notes = "Sample budget for monthly expenses."
        let createdAt = Date()
        let updatedAt = Date()
        
        // When
        let budgetModel = BudgetModel(
            id: id,
            name: name,
            type: type,
            owner: owner,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // Then
        XCTAssertEqual(budgetModel.id, id)
        XCTAssertEqual(budgetModel.name, name)
        XCTAssertEqual(budgetModel.type, type)
        XCTAssertEqual(budgetModel.owner, owner)
        XCTAssertEqual(budgetModel.notes, notes)
        XCTAssertEqual(budgetModel.createdAt, createdAt)
        XCTAssertEqual(budgetModel.updatedAt, updatedAt)
    }
    
    func testBudgetModelConvenienceInitializer() {
        // Given
        let name = "budget"
        let owner = "owner budget"
        
        // When
        let budgetModel = BudgetModel(name: name, owner: owner)
        
        // Then
        XCTAssertFalse(budgetModel.id.uuidString.isEmpty)
        XCTAssertEqual(budgetModel.name, name)
        XCTAssertEqual(budgetModel.type, BudgetType.personal)
        XCTAssertEqual(budgetModel.owner, owner)
        XCTAssertTrue(budgetModel.notes.isEmpty)
        XCTAssertNotNil(budgetModel.createdAt)
        XCTAssertNotNil(budgetModel.updatedAt)
    }
    
    func testBudgetModelDecodingEncoding() {
        // Given
        let id = UUID()
        let name = "Monthly Savings"
        let type = BudgetType.personal
        let owner = "OwnerID"
        let notes = "Saving for vacation."
        let createdAt = Date()
        let updatedAt = Date()
        
        let budgetModel = BudgetModel(
            id: id,
            name: name,
            type: type,
            owner: owner,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        do {
            // When
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(budgetModel)
            let jsonDecoder = JSONDecoder()
            let decodedBudgetModel = try jsonDecoder.decode(BudgetModel.self, from: jsonData)
            
            // Then
            XCTAssertEqual(decodedBudgetModel.id, id)
            XCTAssertEqual(decodedBudgetModel.name, name)
            XCTAssertEqual(decodedBudgetModel.type, type)
            XCTAssertEqual(decodedBudgetModel.owner, owner)
            XCTAssertEqual(decodedBudgetModel.notes, notes)
            XCTAssertEqual(decodedBudgetModel.createdAt.timeIntervalSince1970, createdAt.timeIntervalSince1970, accuracy: 0.001)
            XCTAssertEqual(decodedBudgetModel.updatedAt.timeIntervalSince1970, updatedAt.timeIntervalSince1970, accuracy: 0.001)
        } catch {
            XCTFail("Error encoding or decoding BudgetModel: \(error)")
        }
    }
    
    func testBudgetModelToDictionary() {
        // Given
        let budgetModel = BudgetModel(
            name: "Weekly Groceries",
            owner: "OwnerUserID"
        )
        
        // When
        if let dictionary = budgetModel.toDictionary() {
            // Then
            XCTAssertNotNil(dictionary["_id"])
            XCTAssertEqual(dictionary["_name"] as? String, budgetModel.name)
            //XCTAssertEqual(dictionary["_type"] as? BudgetType, budgetModel.type)
            XCTAssertEqual(dictionary["_owner"] as? String, budgetModel.owner)
            XCTAssertNotNil(dictionary["_notes"])
            XCTAssertNotNil(dictionary["_createdAt"])
            XCTAssertNotNil(dictionary["_updatedAt"])
        } else {
            XCTFail("Failed to convert BudgetModel to dictionary")
        }
    }

}
