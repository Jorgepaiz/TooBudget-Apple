//
//  DataBudgetProtocol.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/12/24.
//

import Foundation

protocol DataBudgetProtocol {
    func createBudget(_ budget: BudgetModel) throws
    func readBudget(id: UUID) throws -> BudgetModel?
    func readBudget(budget: BudgetModel) throws -> BudgetModel?
    func updateBudget(_ budget: BudgetModel) throws
    func deleteBudget(id: UUID) throws
    func deleteBudget(budget: BudgetModel) throws
    func fetchAllBudgets() throws -> [BudgetModel]
}
