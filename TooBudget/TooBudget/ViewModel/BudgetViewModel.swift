//
//  BudgetViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import Foundation
import Observation

@Observable
final class BudgetViewModel: ViewModelProtocol {
    let coordinator: CoordinatorProtocol
    
    init(_ coordinator: BudgetCoordinator) {
        self.coordinator = coordinator
    }
}
