//
//  Utilities.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/7/24.
//

import Foundation

final class Utilities {
    static func saveUserData(_ user: UserModel) {
        UserDefaults.standard.set(user.id, forKey: UserModel.CodingKeys._id.stringValue)
        UserDefaults.standard.set(user.name, forKey: UserModel.CodingKeys._name.stringValue)
        UserDefaults.standard.set(user.surname, forKey: UserModel.CodingKeys._surname.stringValue)
        UserDefaults.standard.set(user.email, forKey: UserModel.CodingKeys._email.stringValue)
    }
    
    static func loadUserData() -> UserModel? {
        guard let id = UserDefaults.standard.string(forKey: UserModel.CodingKeys._id.stringValue),
              let name = UserDefaults.standard.string(forKey: UserModel.CodingKeys._name.stringValue),
              let surname = UserDefaults.standard.string(forKey: UserModel.CodingKeys._surname.stringValue),
              let email = UserDefaults.standard.string(forKey: UserModel.CodingKeys._email.stringValue) else {
            return nil
        }
        return .init(id: id, fullname: "\(name) \(surname)", email: email)
    }
}
