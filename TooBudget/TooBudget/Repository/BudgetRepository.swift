//
//  BudgetRepository.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/13/24.
//

import Foundation
import SwiftData

final class BudgetRepository: DataBudgetProtocol {
    private let context: ModelContext
    
    init() {
        self.context = ModelContext(DataService.shared.container)
    }
    
    private func saveContext(_ error: DataServiceError) throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
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
