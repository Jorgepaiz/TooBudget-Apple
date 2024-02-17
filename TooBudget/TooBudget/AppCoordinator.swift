//
//  AppCoordinator.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Observation
import SwiftUI
import SwiftData

@Observable
final class AppCoordinator {
    private var currentScreen: AppViews
    private var viewFactory: ViewFactory {
        ViewFactory(self)
    }
    
    init() {
        currentScreen = .landing
    }
    
    var currentView: some View {
        return viewFactory.view(for: currentScreen)
            .modelContainer(DataService.shared.container)
    }
    
    func navigate(to view: AppViews) {
        self.currentScreen = view
    }
}
