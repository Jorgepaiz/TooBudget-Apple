//
//  HomeCoordinator.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

final class HomeCoordinator: CoordinatorProtocol {
    let appCoordinator: AppCoordinator
    
    init(_ appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func show() -> any View {
        HomeView(HomeViewModel(self))
    }
}
