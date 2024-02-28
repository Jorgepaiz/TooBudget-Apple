//
//  BudgetViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import Foundation
import Observation

@Observable
final class BudgetViewModel {
    let coordinator: BudgetCoordinator
    
    init(_ coordinator: BudgetCoordinator) {
        self.coordinator = coordinator
    }
    
    func logOut() {
        let _ = AuthRepository().signOut()
            .sink { completion in
                switch completion {
                case .finished:
                    AnalyticsService.logOut()
                    self.coordinator.appCoordinator.navigate(to: .landing)
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { _ in }
    }
}
