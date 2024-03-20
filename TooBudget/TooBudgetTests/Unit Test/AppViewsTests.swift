//
//  AppViewsTests.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/22/24.
//

import XCTest
@testable import TooBudget

final class AppViewsTests: XCTestCase {

    func testLoadingView() {
        let view = AppViews.loading
        XCTAssertEqual(view, .loading)
    }
    
    func testLandingView() {
        let view = AppViews.landing
        XCTAssertEqual(view, .landing)
    }
    
    func testHomeView() {
        let view = AppViews.home
        XCTAssertEqual(view, .home)
    }
    
    func testBudgetView() {
        let view = AppViews.budget
        XCTAssertEqual(view, .budget)
    }

}
