//
//  DataServiceError.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/7/24.
//

import Foundation

enum DataServiceError: Error {
    // general
    case deleteModel
    
    // user
    case createUser
    case readUser
    case updateUser
    case deleteUser
    case userNotFound
    
    // budget
    case createBudget
    case readBudget
    case updateBudget
    case deleteBudget
    case budgetNotFound
}
