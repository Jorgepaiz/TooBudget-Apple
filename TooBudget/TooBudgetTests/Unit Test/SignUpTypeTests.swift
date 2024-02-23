//
//  SignUpTypeTests.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/22/24.
//

import XCTest
@testable import TooBudget

final class SignUpTypeTests: XCTestCase {

    func testCodable() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let emailType = SignUpType.email
        
        let encodedData = try encoder.encode(emailType)
        let decodedType = try decoder.decode(SignUpType.self, from: encodedData)
        
        XCTAssertEqual(emailType, decodedType)
    }

}
