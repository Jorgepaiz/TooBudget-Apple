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
    
    @ViewBuilder
    func view(for screen: AppViews) -> some View {
        switch screen {
        case .loading:
            Text("Loading...")
        case .landing:
            LandingCoordinator(coordinator).show()
        case .home:
            HomeCoordinator(coordinator).show()
        case .budget:
            BudgetCoordinator(coordinator).show()
        }
    }
}
