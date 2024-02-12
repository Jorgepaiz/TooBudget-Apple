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
        let firebaseService = FirebaseService()
        
        firebaseService.signOut()
        coordinator.appCoordinator.navigate(to: .landing)
    }
}
