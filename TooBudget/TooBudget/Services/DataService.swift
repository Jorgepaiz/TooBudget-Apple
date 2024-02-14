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
    init() {}
    
    private let model = UserModel.self
    
    func setupContainer(inMemory: Bool = false) -> ModelContainer {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            let container = try ModelContainer(for: model, configurations: configuration)
            return container
        } catch {
            fatalError("Could not create the database on this device.")
        }
    }
    
    func deleteModel() throws {
        let context = ModelContext(setupContainer())
        do {
            try context.delete(model: model)
        } catch {
            throw DataServiceError.deleteModel
        }
    }
    
    func testDataBase() {
        var user: UserModel {
            UserModel(id: "u" + String(Int.random(in: 0...100)), fullname: "a b", email: "a@b.com")
        }
        
        let userRepository = UserRepository()
        do {
            var users = try userRepository.fetchAllUsers()
            print("Users: \(users)")
            try deleteModel()
            users = try userRepository.fetchAllUsers()
            print("Users: \(users)")
            try userRepository.createUser(user)
            users = try userRepository.fetchAllUsers()
            print("Users: \(users)")
            try userRepository.createUser(user)
            users = try userRepository.fetchAllUsers()
            print("Users: \(users)")
        } catch {
            print("Error on testDataBase: \(error.localizedDescription)")
        }
    }
}

/*
extension DataService: DataBudgetProtocol {
    func createBudget(_ budget: BudgetModel) throws {
        context.insert(budget)
        try saveContext(.createBudget)
    }
    
    func readBudget(id: UUID) throws -> BudgetModel? {
        var descriptor = FetchDescriptor<BudgetModel>(
            predicate: #Predicate { $0.id == id },
            sortBy: [.init(\.createdAt)]
        )
        descriptor.fetchLimit = 1
        do {
            return (try context.fetch(descriptor)).first
        } catch {
            throw DataServiceError.readBudget
        }
    }
    
    func readBudget(budget: BudgetModel) throws -> BudgetModel? {
        try readBudget(id: budget.id)
    }
    
    func updateBudget(_ budget: BudgetModel) throws {
        try saveContext(.updateBudget)
    }
    
    func deleteBudget(id: UUID) throws {
        guard let budget = try readBudget(id: id) else {
            throw DataServiceError.budgetNotFound
        }
        
        try deleteBudget(budget: budget)
    }
    
    func deleteBudget(budget: BudgetModel) throws {
        context.delete(budget)
        try saveContext(.deleteBudget)
    }
    
    func fetchAllBudgets() throws -> [BudgetModel] {
        let descriptor = FetchDescriptor<BudgetModel>(sortBy: [SortDescriptor(\.name)])
        do {
            return try context.fetch(descriptor)
        } catch {
            throw DataServiceError.readBudget
        }
    }
    
}
*/

