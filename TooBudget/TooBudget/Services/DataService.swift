//
//  DataService.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/7/24.
//

import Foundation
import SwiftData

final class DataService {
    // singleton
    static let shared = DataService()
    private init() {}
    
    @MainActor
    private let context = setupContainer(inMemory: false)
    
    @MainActor
    private static func setupContainer(inMemory: Bool) -> ModelContext {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            let container = try ModelContainer(for: UserModel.self, configurations: configuration)
            return container.mainContext
        } catch {
            fatalError("Could not create the database on this device.")
        }
    }
    
    @MainActor
    func fetchAllUsers() throws -> [UserModel] {
        let descriptor = FetchDescriptor<UserModel>(sortBy: [SortDescriptor(\.name)])
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Error fetch all user from DataBase, detail: \(error.localizedDescription)")
            throw DataSeviceError.featchAllUsers
        }
    }
    
    @MainActor
    func insertUser(_ user: UserModel) throws {
        context.insert(user)
        do {
            try context.save()
        } catch {
            print("Error inserting a new user from DataBase, detail: \(error.localizedDescription)")
            throw DataSeviceError.insertUser
        }
    }
    
    @MainActor
    func deleteAllData() throws {
        do {
            try context.delete(model: UserModel.self)
        } catch {
            print("Error deleting all users, detail: \(error.localizedDescription)")
            throw DataSeviceError.deleteAllusers
        }
    }
    
}
