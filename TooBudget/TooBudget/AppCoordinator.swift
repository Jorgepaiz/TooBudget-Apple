//
//  AppCoordinator.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI
import Observation

@Observable
final class AppCoordinator {
    private var currentScreen: AppViews = .loading
    
    init() {
        currentScreen = .landing
    }
    
    private func view(for screen: AppViews) -> AnyView {
        switch screen {
        case .loading:
            return AnyView(Text("Loading..."))
        case .landing:
            return AnyView(LandingCoordinator(self).show())
        case .home:
            return AnyView(HomeCoordinator(self).show())
        case .budget:
            return AnyView(BudgetCoordinator(self).show())
        }
    }
    
    var currentView: AnyView {
        view(for: currentScreen)
    }
    
    func navigate(to view: AppViews) {
        self.currentScreen = view
    }
}
