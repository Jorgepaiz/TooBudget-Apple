//
//  TooBudgetApp.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftData
import SwiftUI
import TipKit

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
        }
    }

    private func configureTips() {
        do {
            try Tips.resetDatastore()
            try Tips.configure([
                .displayFrequency(.immediate)
            ])
        } catch {
            print("Error configuring Tips: \(error)")
        }
    }
}
