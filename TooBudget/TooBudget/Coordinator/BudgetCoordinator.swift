//
//  BudgetCoordinator.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import SwiftUI

final class BudgetCoordinator {
    let appCoordinator: AppCoordinator
    
    init(_ appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func show() -> some View {
        BudgetView(BudgetViewModel(self))
    }
}
