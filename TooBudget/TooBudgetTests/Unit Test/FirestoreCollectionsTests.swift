//
//  FirestoreCollectionsTests.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/22/24.
//

import XCTest
@testable import TooBudget

final class FirestoreCollectionsTests: XCTestCase {

    func testUsersCollectionName() {
        let collection = FirestoreCollections.users
        XCTAssertEqual(collection.name, "Users", "The collection name for 'users' should be 'Users'")
    }

}
