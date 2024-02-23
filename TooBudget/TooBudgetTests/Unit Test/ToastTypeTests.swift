//
//  ToastTypeTests.swift
//  TooBudgetTests
//
//  Created by Jorge Paiz on 2/22/24.
//

import XCTest
@testable import TooBudget
import SwiftUI

// Mocked shape style for testing purposes
struct MockShapeStyle: ShapeStyle {
    let id: Int
    static func ==(lhs: MockShapeStyle, rhs: MockShapeStyle) -> Bool {
        return lhs.id == rhs.id
    }
}

final class ToastTypeTests: XCTestCase {

    func testIcon() {
        XCTAssertEqual(ToastType.info.icon, "exclamationmark.circle.fill")
        XCTAssertEqual(ToastType.success.icon, "checkmark.circle.fill")
        XCTAssertEqual(ToastType.warning.icon, "exclamationmark.triangle.fill")
        XCTAssertEqual(ToastType.error.icon, "x.circle.fill")
    }
    
    /*func testColorForToastType() {
        // Assuming `.gradient` returns a mock object with identifiable properties for testing
        typealias Gradient = MockShapeStyle
        
        let infoGradient = Gradient(id: 1)
        let successGradient = Gradient(id: 2)
        let warningGradient = Gradient(id: 3)
        let errorGradient = Gradient(id: 4)
        
        // Replace 'YourAppModuleName' with your actual module's name
        XCTAssertEqual(ToastType.info.color as! Gradient, infoGradient)
        XCTAssertEqual(ToastType.success.color as! Gradient, successGradient)
        XCTAssertEqual(ToastType.warning.color as! Gradient, warningGradient)
        XCTAssertEqual(ToastType.error.color as! Gradient, errorGradient)
    }
    */

}
