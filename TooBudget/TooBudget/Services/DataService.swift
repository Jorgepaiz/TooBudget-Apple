//
//  DataService.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/12/24.
//

import Foundation
import SwiftData

final class DataService: DataProtocol {
    // singleton
    static let shared = DataService()
    private init() {}
    
    var inMemory = false
    
    lazy var container: ModelContainer = {
        setupContainer()
    }()
    
    private func setupContainer() -> ModelContainer {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            return try ModelContainer(for: UserModel.self, BudgetModel.self, configurations: configuration)
        } catch {
            fatalError("Could not create the database on this device.")
        }
    }
    
    func deleteModel() throws {
        let context = ModelContext(container)
        try context.delete(model: UserModel.self)
    }
    
    func testDataBase() {
        var user: UserModel {
            UserModel(
                id: "u" + String(Int.random(in: 0...100)),
                fullname: "a b",
                email: "a@b.com"
            )
        }
        
        let userRepository = UserRepository()
        do {
            func printUsersAfterOperation(_ operation: () throws -> Void) throws {
                try operation()
                let users = try userRepository.fetchAllUsers()
                print("Users: \(users)")
            }
            
            // Execute the sequence of operations with the same user object.
            try printUsersAfterOperation {}
            try printUsersAfterOperation { try self.deleteModel() }
            try printUsersAfterOperation { try userRepository.createUser(user) }
            try printUsersAfterOperation { try userRepository.createUser(user) }
        } catch {
            print("Error on testDataBase: \(error.localizedDescription)")
        }
    }
}

extension DataService: Identifiable, Equatable {
    static func == (lhs: DataService, rhs: DataService) -> Bool {
        lhs.id == rhs.id
    }
}
