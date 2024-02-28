//
//  AppViews.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Foundation

enum AppViews {
    case loading
    case landing
    case home
    case budget
    
    var name: String {
        switch self {
        case .loading:
            "Loading"
        case .landing:
            "Landing"
        case .home:
            "Home"
        case .budget:
            "Budget"
        }
    }
}
