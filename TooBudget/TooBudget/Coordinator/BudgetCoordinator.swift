//
//  BudgetCoordinator.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import SwiftUI

final class BudgetCoordinator: CoordinatorProtocol {
    let appCoordinator: AppCoordinator
    
    init(_ appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func show() -> any View {
        BudgetView(BudgetViewModel(self))
    }
}
