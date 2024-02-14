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
        self.context = ModelContext(DataService.shared.setupContainer())
    }
    
    private func saveContext(_ error: DataServiceError) throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func createUser(_ user: UserModel) throws {
        context.insert(user)
        try saveContext(.createUser)
    }
    
    func readUser(id: String) throws -> UserModel? {
        var descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.id == id },
            sortBy: [.init(\.createdAt)]
        )
        descriptor.fetchLimit = 1
        do {
            return (try context.fetch(descriptor)).first
        } catch {
            throw DataServiceError.readUser
        }
    }
    
    func readUser(user: UserModel) throws -> UserModel? {
        return try readUser(id: user.id)
    }
    
    func updateUser(_ user: UserModel) throws {
        try saveContext(.updateUser)
    }
    
    func deleteUser(id: String) throws {
        guard let user = try readUser(id: id) else {
            throw DataServiceError.userNotFound
        }
        
        try deleteUser(user: user)
    }
    
    func deleteUser(user: UserModel) throws {
        context.delete(user)
        try saveContext(.deleteUser)
    }
    
    func fetchAllUsers() throws -> [UserModel] {
        let descriptor = FetchDescriptor<UserModel>(sortBy: [SortDescriptor(\.name)])
        do {
            return try context.fetch(descriptor)
        } catch {
            throw DataServiceError.readUser
        }
    }
    
    
}
