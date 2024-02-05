//
//  HomeViewModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import Foundation
import Observation

@Observable
final class HomeViewModel: ViewModelProtocol {
    let coordinator: CoordinatorProtocol
    
    init(_ coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func logOut() {
        let firebaseService = FirebaseService()
        
        firebaseService.signOut()
        coordinator.appCoordinator.navigate(.landing)
    }
}
