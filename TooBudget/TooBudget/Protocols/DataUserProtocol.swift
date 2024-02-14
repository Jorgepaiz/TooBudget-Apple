//
//  DataUserProtocol.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/12/24.
//

import Foundation

protocol DataUserProtocol {
    func createUser(_ user: UserModel) throws
    func readUser(id: String) throws -> UserModel?
    func readUser(user: UserModel) throws -> UserModel?
    func updateUser(_ user: UserModel) throws
    func deleteUser(id: String) throws
    func deleteUser(user: UserModel) throws
    func fetchAllUsers() throws -> [UserModel]
}
