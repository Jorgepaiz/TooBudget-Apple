//
//  BudgetTypeTests.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/22/24.
//

import XCTest
@testable import TooBudget

final class BudgetTypeTests: XCTestCase {

    func testBudgetTypeName() {
        XCTAssertEqual(BudgetType.personal.name, "Personal")
        XCTAssertEqual(BudgetType.family.name, "Family")
        XCTAssertEqual(BudgetType.special.name, "Special")
    }
    
    func testBudgetTypeDescription() {
        XCTAssertEqual(BudgetType.personal.description, "budget_type_personal")
        XCTAssertEqual(BudgetType.family.description, "budget_type_family")
        XCTAssertEqual(BudgetType.special.description, "budget_type_special")
    }
    
    func testBudgetTypeEncodingDecoding() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for type in [BudgetType.personal, BudgetType.family, BudgetType.special] {
            let data = try encoder.encode(type)
            let decodedType = try decoder.decode(BudgetType.self, from: data)
            XCTAssertEqual(decodedType, type)
        }
    }

}
