//
//  ToastType.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/9/24.
//

import Foundation
import SwiftUI

enum ToastType {
    case info
    case success
    case warning
    case error
    
    var icon: String {
        switch self {
        case .info:
            return "exclamationmark.circle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .error:
            return "x.circle.fill"
        }
    }
    
    var color: some ShapeStyle {
        switch self {
        case .info:
            return .tint2.gradient
        case .success:
            return .trueTetradic3.gradient
        case .warning:
            return .trueTetradic2.gradient
        case .error:
            return .trueTetradic1.gradient
        }
    }
}
