//
//  ViewFactory.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/10/24.
//

import SwiftUI

final class ViewFactory {
    private let coordinator: AppCoordinator

    init(_ coodinator: AppCoordinator) {
        self.coordinator = coodinator
    }
    
    func view(for screen: AppViews) -> AnyView {
        switch screen {
        case .loading:
            return AnyView(Text("Loading..."))
        case .landing:
            return AnyView(LandingCoordinator(coordinator).show())
        case .home:
            return AnyView(HomeCoordinator(coordinator).show())
        case .budget:
            return AnyView(BudgetCoordinator(coordinator).show())
        }
    }
}
