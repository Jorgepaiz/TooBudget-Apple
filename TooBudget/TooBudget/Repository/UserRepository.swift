//
//  UserRepository.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import Foundation
import SwiftData

final class UserRepository: DataUserProtocol {
    private let context: ModelContext
    
    init() {
        self.context = ModelContext(DataService.shared.container)
    }
    
    private func saveContext(_ error: DataServiceError) throws {
        do {
            try context.save()
        } catch {
            CrashlyticsService.logError(error)
            throw error
        }
    }
    
    func createUser(_ user: UserModel) throws {
        context.insert(user)
        try saveContext(.createUser)
    }
    
    func readUserBy(id: String) throws -> UserModel? {
        var descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.id == id },
            sortBy: [.init(\.createdAt)]
        )
        descriptor.fetchLimit = 1
        do {
            return (try context.fetch(descriptor)).first
        } catch {
            CrashlyticsService.logError(error)
            throw DataServiceError.readUser
        }
    }
    
    func readUserBy(model user: UserModel) throws -> UserModel? {
        return try readUserBy(id: user.id)
    }
    
    func updateUser(_ user: UserModel) throws {
        try saveContext(.updateUser)
    }
    
    func deleteUserBy(id: String) throws {
        guard let user = try readUserBy(id: id) else {
            throw DataServiceError.userNotFound
        }
        
        try deleteUserBy(model: user)
    }
    
    func deleteUserBy(model user: UserModel) throws {
        context.delete(user)
        try saveContext(.deleteUser)
    }
    
    func fetchAllUsers() throws -> [UserModel] {
        let descriptor = FetchDescriptor<UserModel>(sortBy: [SortDescriptor(\.name)])
        do {
            return try context.fetch(descriptor)
        } catch {
            CrashlyticsService.logError(error)
            throw DataServiceError.readUser
        }
    }
    
    func getCurrentUser() -> UserModel? {
        do {
            return (try fetchAllUsers()).first
        } catch {
            CrashlyticsService.logError(error)
        }
        return nil
    }
    
}
