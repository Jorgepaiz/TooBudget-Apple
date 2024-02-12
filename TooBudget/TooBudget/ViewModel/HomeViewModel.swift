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
    }
    
    private var currentUser: UserModel?
    private var currentBudget: BudgetModel?
    
    private func fetchAllUsers() async -> [UserModel] {
        let userRepository = UserRepository()
        do {
            return try await userRepository.fetchAll()
        } catch {
            fatalError("Error fetching all users, detail \(error.localizedDescription)")
        }
    }
    
    func logOut() {
        let firebaseService = FirebaseService()
        
        firebaseService.signOut()
        coordinator.appCoordinator.navigate(to: .landing)
    }
    
    func checkCurrentBudget() async {
        let users = await fetchAllUsers()
        if let user = users.first {
            currentUser = user
        } else {
            coordinator.appCoordinator.navigate(to: .landing)
        }
        if let budget = currentUser?.currentBudget {
            currentBudget = budget
        } else {
            coordinator.appCoordinator.navigate(to: .budget)
        }
    }
}
