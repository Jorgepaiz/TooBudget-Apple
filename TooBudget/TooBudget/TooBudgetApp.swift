//
//  TooBudgetApp.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI
import TipKit
import SwiftData

@main
struct TooBudgetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let appCoordinator = AppCoordinator()
    
    init() {
        configureTips()
    }
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.currentView
                .modelContainer(for: UserModel.self)
        }
    }

    private func configureTips() {
        do {
            try Tips.resetDatastore()
            try Tips.configure([
                .displayFrequency(.immediate),
            ])
        } catch {
            print("Error configuring Tips: \(error)")
        }
    }
}
