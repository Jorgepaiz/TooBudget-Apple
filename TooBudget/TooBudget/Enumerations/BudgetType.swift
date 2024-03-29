//
//  BudgetType.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/7/24.
//

import Foundation

enum BudgetType: String, Codable {
    case personal
    case family
    case special
    
    var name: String {
        self.rawValue.capitalized
    }
    
    var description: String {
        switch self {
        case .personal:
            return "budget_type_personal"
        case .family:
            return "budget_type_family"
        case .special:
            return "budget_type_special"
        }
    }
}
