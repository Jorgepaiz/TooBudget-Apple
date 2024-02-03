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
    private var _currentView: AnyView
    
    init() {
        self._currentView = AnyView(Text("Loading..."))
    }
    
    var currentView: AnyView {
        _currentView
    }
    
    var navigate: (Views) -> Void {
        { [unowned self] view in
            switch view {
            case .landing:
                _currentView = AnyView(LandingCoordinator(self).show())
                
            case .home:
                _currentView = AnyView(HomeCoordinator(self).show())
            }
        }
    }
}
