//
//  BudgetViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class BudgetViewModel {
    private let coordinator: BudgetCoordinator
    private let context: ModelContext
    private var currentUser: UserModel?
    
    init(_ coordinator: BudgetCoordinator) {
        self.coordinator = coordinator
        self.currentUser = UserRepository().getCurrentUser()
        self.context = ModelContext(DataService.shared.container)
        print("init -> currentUser: \(String(describing: self.currentUser))")
    }
    
    var isThereDefaultBudget: Bool {
        currentUser?.currentBudget != nil
    }
    
    func setDefaultBudget(_ budget: BudgetModel) {
        if let user = currentUser {
            user.currentBudget = budget
        }
    }
    
    func getNewBudget() -> BudgetModel {
        print("===> getNewBudget")
        var budget = BudgetModel()
        if let user = currentUser {
            print("---> currentUser")
            budget = BudgetModel(owner: user.getFullname())
            user.currentBudget = budget
            user.budgets.append(budget)
            try? UserRepository().updateUser(user)
        }
        return budget
    }
    
    func getBudgets() -> [BudgetModel] {
        print("===> getBugets")
        if let user = currentUser {
            print("---> currentUser")
            return user.budgets
        }
        return [BudgetModel]()
    }
    
    func goToHome() {
        coordinator.appCoordinator.navigate(to: .home)
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
