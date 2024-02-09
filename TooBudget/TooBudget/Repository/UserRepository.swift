//
//  UserRepository.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import Foundation

final class UserRepository {
    var dataService: DataService
    
    init(dataService: DataService = .shared) {
        self.dataService = dataService
    }
    
    func fetchAll() async throws -> [UserModel] {
        return try await dataService.fetchAllUsers()
    }
    
    func createUser(_ user: UserModel) async throws {
        try await dataService.insertUser(user)
    }
    
    func deleteAll() async throws {
        try await dataService.deleteAllData()
    }
    
}
