//
//  LandingCoordinator.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

final class LandingCoordinator {
    let appCoordinator: AppCoordinator

    init(_ appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func show() -> some View {
        LandingView(LandingViewModel(self))
    }
    
}
