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
    private var budgets: [BudgetModel]?
    
    init(_ coordinator: BudgetCoordinator) {
        self.coordinator = coordinator
        self.context = ModelContext(DataService.shared.container)
        self.currentUser = UserRepository().getCurrentUser()
        self.budgets = try? BudgetRepository().fetchAllBudgets()
    }
    
    var isThereDefaultBudget: Bool {
        currentUser?.currentBudget != nil
    }
    
    func setDefaultBudget(_ budget: BudgetModel) {
        if let user = currentUser {
            user.currentBudget = budget.id
        }
    }
    
    func getNewBudget() -> BudgetModel {
        var budget = BudgetModel()
        if let user = currentUser {
            budget = BudgetModel(owner: user.id)
            user.currentBudget = budget.id
            user.budgets.append(budget.id)
            try? UserRepository().updateUser(user)
            try? BudgetRepository().createBudget(budget)
        }
        return budget
    }
    
    func getBudgets() -> [BudgetModel] {
        let budget1 = BudgetModel(id: UUID(), name: "First Budget", type: .personal, owner: "my", notes: "my first note")
        let budget2 = BudgetModel(id: UUID(), name: "Second Budget", type: .family, owner: "my", notes: "my second note")
        let budget3 = BudgetModel(id: UUID(), name: "Third Budget", type: .special, owner: "my", notes: "my third notes")
        let tmpBudgets = [budget1, budget2, budget3]
        return tmpBudgets
//        return budgets ?? []
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
