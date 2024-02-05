//
//  TooBudgetApp.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

@main
struct TooBudgetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.currentView
        }
    }
}
