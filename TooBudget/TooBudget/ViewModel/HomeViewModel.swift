//
//  HomeViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    let coordinator: HomeCoordinator
    
    init(_ coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        self.currentUser = UserRepository().getCurrentUser()
    }
    
    private var currentUser: UserModel?
    private var currentBudget: BudgetModel?
    
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
    
    func goToBudget() {
        self.coordinator.appCoordinator.navigate(to: .budget)
    }
    

    func checkCurrentBudget() {
        if let budget = currentUser?.currentBudget {
            currentBudget = budget
        } else {
            coordinator.appCoordinator.navigate(to: .budget)
        }
    }
}
