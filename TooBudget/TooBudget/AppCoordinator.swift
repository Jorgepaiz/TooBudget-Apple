//
//  AppCoordinator.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Observation
import SwiftUI

@Observable
final class AppCoordinator {
    private var currentScreen: AppViews
    private var viewFactory: ViewFactory {
        return ViewFactory(self)
    }
    
    init() {
        currentScreen = .landing
    }
    
    var currentView: AnyView {
        viewFactory.view(for: currentScreen)
    }
    
    func navigate(to view: AppViews) {
        self.currentScreen = view
    }
}
